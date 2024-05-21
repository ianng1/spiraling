extends CharacterBody2D

# --------- VARIABLES ---------- #

@export_category("Player Properties") # You can tweak these changes according to your likings
@export var move_speed : float = 200

@export_category("Toggle Functions") # Double jump feature is disable by default (Can be toggled from inspector)
#@export var double_jump : = false

# Indicator of movement direction to set animation.
var move_right : bool = true
var freeze_player_movement = false
var center_x = 820
var center_y = 251

# --------- BUILT-IN FUNCTIONS ---------- #

func _process(_delta):
	# Calling functions
	movement()
	
	
# --------- CUSTOM FUNCTIONS ---------- #

# <-- Player Movement Code -->
func movement():
	print(position.x)
	print(position.y)
	# Move Player
	var inputAxis = Input.get_axis("Left", "Right")
	move_right = move_right if inputAxis == 0 else inputAxis > 0
	# velocity = Vector2(inputAxis * move_speed, velocity.y)
	
	var offset_y = position.y - center_y
	var offset_x = position.x - center_x
	velocity = Vector2(offset_y * -0.77 * inputAxis, offset_x * 0.77 * inputAxis)
	move_and_slide()

