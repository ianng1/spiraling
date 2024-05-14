extends Node2D

# Reference: 
# - https://www.youtube.com/watch?v=3bENnUEa9mY
# - https://www.reddit.com/r/godot/comments/16fy52m/check_whether_node_on_right_side_of_viewport/
# - https://www.reddit.com/r/godot/comments/40cm3w/looping_through_all_children_and_subchildren_of_a/
	

@export var layer = 1
var speed_offset = 0.5
var position_offset

var canvas_size = 1625
# Offset jail from tilemap position, and size.
var jail_offset = 905
var jail_size = 300

@onready var player = $"../Player"
@onready var husband = $"A_husband"
@onready var level = $"../Level"

func _ready():
	position_offset = position.x

func _process(_delta):
	if player == null:
		return

	if level == null:
		return
	
	for node in level.get_children():
		var screen_pos = get_viewport().canvas_transform * node.global_position
		var viewport_x = get_viewport().size.x
		var buffer = 200
		
		if node.get_name() in ["c_Jail", "617wallmark"]:
			screen_pos.x += jail_offset

		if screen_pos.x < -buffer:
			node.position.x += canvas_size
		# Move the node to left if is to the right of viewport
#		# Add 10 for buffer.
		elif screen_pos.x> viewport_x + buffer:
			node.position.x -= canvas_size

