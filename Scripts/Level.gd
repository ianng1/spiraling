extends Node2D

# Reference: 
# - https://www.reddit.com/r/godot/comments/16fy52m/check_whether_node_on_right_side_of_viewport/
# - https://www.reddit.com/r/godot/comments/40cm3w/looping_through_all_children_and_subchildren_of_a/

# Default configs, need to change when scene width is changed.
var canvas_size = 3260
var stretch_scale = 2
# Offset jail from tilemap position.
var jail_offset = 905

@onready var level = $"../Level"

func _ready():
	pass

func _process(_delta):
	if level == null:
		return
	
	# Move nodes to left and rights when they are outsides the scene.
	for node in level.get_children():
		var screen_pos = get_viewport().canvas_transform * node.global_position
		var viewport_x = get_viewport().size.x
		# Buffer to set when to move nodes arounds to avoid glitch.
		var buffer = 300
		
		# The actual drawing of jail is offset from the position of tilemap.
		if node.get_name() in ["c_Jail", "617wallmark"]:
			screen_pos.x += jail_offset
		if screen_pos.x < -buffer:
			node.position.x += canvas_size
		# Need to adjust buffer size by window scale
		elif screen_pos.x > viewport_x - buffer * viewport_x * stretch_scale / canvas_size:
			node.position.x -= canvas_size
