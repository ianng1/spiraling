extends CharacterBody2D

# --------- VARIABLES ---------- #

@export_category("Player Properties") # You can tweak these changes according to your likings
@export var move_speed : float = 400

@export_category("Toggle Functions") # Double jump feature is disable by default (Can be toggled from inspector)
#@export var double_jump : = false

# Indicator of movement direction to set animation.
var move_right : bool = true
var freeze_player_movement = false
var level = 1
var max_level = 1

@onready var player_sprite = $AnimatedSprite2D
@onready var particle_trails = $ParticleTrails
@onready var level_globals = get_node("/root/Level_01")
@onready var player_jail = %mc_jail
@onready var audio_player = $footstep_player
# --------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	name = "Player"

func _process(_delta):
	# Calling functions
	if(get_parent().name == "Level_01" and !get_parent().freeze_player_movement):
		movement()
		player_animations()
	else:
		# Freeze movement, play idle.
		player_sprite.play("Idle")
	flip_player()
	
	# Determine player's level
	update_level()
	
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
	if level_globals:
		max_level = level_globals.max_level
	
	# Move player to upper lower level when close to its jail.
	var offset = 20
	var jail_x = player_jail.position.x
	if position.x > jail_x - offset and position.x < jail_x + offset:
		if move_right and level < max_level:
			level += 1
		elif (!move_right) and level > 1:
			level -= 1
	GameStates.player_level = level

