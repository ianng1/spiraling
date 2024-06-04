extends AnimatedSprite2D


var starting_location: Vector2
var angle: float = 0.0
var radius: float = 60.0
var speed: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	starting_location = position

func _process(delta):
	# Update the angle based on speed and delta time
	angle += speed * delta
	
	# Calculate the new position using the angle
	var new_x = starting_location.x + radius * cos(angle)
	var new_y = starting_location.y + radius * sin(angle)
	
	# Update the position of the sprite
	position = Vector2(new_x, new_y)
	
	# Optionally rotate the sprite as it moves
	rotation_degrees += 0.8
