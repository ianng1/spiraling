extends CharacterBody2D

# --------- VARIABLES ---------- #

@export_category("Player Properties") # You can tweak these changes according to your likings
@export var move_speed : float = 400

@export_category("Toggle Functions") # Double jump feature is disable by default (Can be toggled from inspector)
#@export var double_jump : = false

# Indicator of movement direction to set animation.
var move_right : bool = true
var freeze_player_movement = false

@onready var player_sprite = $AnimatedSprite2D
@onready var particle_trails = $ParticleTrails


# --------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	name = "Player"

func _process(_delta):
	# Calling functions
	if(get_parent().name == "Level_01" and !get_parent().freeze_player_movement):
		movement()
		player_animations()
		flip_player()
	
	
# --------- CUSTOM FUNCTIONS ---------- #

# <-- Player Movement Code -->
func movement():
	# Move Player
	var inputAxis = Input.get_axis("Left", "Right")
	move_right = move_right if inputAxis == 0 else inputAxis > 0
	# velocity = Vector2(inputAxis * move_speed, velocity.y)
	velocity = Vector2(inputAxis * move_speed, 0)
	move_and_slide()

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


func _on_area_2d_area_entered(area):
	if area.name == "Chest":
		print("hi")

