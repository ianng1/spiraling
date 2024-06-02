extends CharacterBody2D

# --------- VARIABLES ---------- #

@export_category("Player Properties") # You can tweak these changes according to your likings
@export var move_speed : float = 500

@export_category("Toggle Functions") # Double jump feature is disable by default (Can be toggled from inspector)
#@export var double_jump : = false

# Indicator of movement direction to set animation.
var move_right : bool = true
var freeze_player_movement = false
var level = 1
var max_level = 1
var prev_x
# whether triggered mc dialogue before.
var mc_triggered = false

@onready var player_sprite = $AnimatedSprite2D
@onready var particle_trails = $ParticleTrails
@onready var level_globals = get_node("/root/Level_01")
@onready var player_jail = %mc_jail
@onready var audio_player = $footstep_player
@onready var mc = $"../Level_final_scene/mc"
# --------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	name = "Player"
	prev_x = position.x

func _process(_delta):
	# Calling functions
	if GameStates.player_movement_freeze or (get_parent().name == "Level_01" and get_parent().freeze_player_movement):
		# Freeze movement, play idle.
		player_sprite.play("Idle")
	else:
		movement()
		player_animations()
		
	flip_player()
	
	# Determine player's level
	update_level()
	
	# On final level, triger mc's dialogue when close
	if get_parent().name == "Level_final":
		check_mc_trigger_dialogue()
		trigger_end_game()
	
# --------- CUSTOM FUNCTIONS ---------- #

# <-- Player Movement Code -->
func movement():
	# Move Player
	var inputAxis = Input.get_axis("Left", "Right")
	move_right = move_right if inputAxis == 0 else inputAxis > 0
	# velocity = Vector2(inputAxis * move_speed, velocity.y)
	velocity = Vector2(inputAxis * move_speed, 0)
	move_and_slide()
	if abs(velocity.x) > 0:
		if not audio_player.playing:
			audio_player.play()
	else:
		if audio_player.playing:
			audio_player.stop()

# Handle Player Animations
func player_animations():
	# Always emitting the smog after the player.
	# TODO:  maybe delete the smog as we do not need it.
	particle_trails.emitting = false
	
	if abs(velocity.x) > 0:
		player_sprite.play("Walk", 1.5)
	else:
		player_sprite.play("Idle")

# Flip player sprite based on X velocity
func flip_player():
	if move_right: 
		player_sprite.flip_h = false
	else:
		player_sprite.flip_h = true
		
func update_level():
	max_level = GameStates.player_max_level
	
	# Move player to upper lower level when close to its jail.
	var jail_x = player_jail.position.x
	var cur_x = position.x
	if prev_x < jail_x and cur_x > jail_x and level < max_level:
		level += 1
	if prev_x > jail_x and cur_x < jail_x and level > 1:
		level -= 1
	GameStates.player_level = level
	prev_x = cur_x
	
func check_mc_trigger_dialogue():
	if mc == null:
		return
	var mc_x = mc.position.x
	var buffer = 100
	var player_x = position.x
	# Turn MC to face player
	if player_x > mc_x:
		mc.scale.x = -1
	else:
		mc.scale.x = 1
	if !mc_triggered and player_x > mc_x - buffer and player_x < mc_x + buffer:
		mc.load_dialogue()
		mc_triggered = true
		GameStates.player_movement_freeze = true

func trigger_end_game():
	var jail_x = player_jail.position.x
	var cur_x = position.x
	if mc_triggered and cur_x >= jail_x - 2  and cur_x <= jail_x + 2:
		get_tree().change_scene_to_file("res://Scenes/end_game.tscn")
		
