extends Node2D

# Reference: 
# - https://www.reddit.com/r/godot/comments/16fy52m/check_whether_node_on_right_side_of_viewport/
# - https://www.reddit.com/r/godot/comments/40cm3w/looping_through_all_children_and_subchildren_of_a/

# Default configs, need to change when scene width is changed.
var canvas_size = 3260
var stretch_scale = 2
# Offset jail from tilemap position.
var jail_offset = 2013

@onready var level = $"../Level"

# Level related items to show or hide.
@onready var bang_Sprite2D = %bang_Sprite2D_UI

func _ready():
	pass

func _process(_delta):
	update_items_positions()
	update_scene()

# Move nodes to left and rights when they are outsides the scene for looping.
func update_items_positions():
	if level == null:
		return

	for node in level.get_children():
		var screen_pos = get_viewport().canvas_transform * node.global_position
		var viewport_x = get_viewport().size.x

		# The actual drawing of jail is offset from the position of tilemap.
		if node.get_name() in ["617scratchmark"]:
			screen_pos.x += jail_offset
		
		# Move assets to left and right.
		if screen_pos.x < -canvas_size/2:
			node.position.x += canvas_size
		# Need to adjust buffer size by window scale
		elif screen_pos.x > canvas_size/2:
			node.position.x -= canvas_size
			
# Update items in the scene for each levels.
func update_scene():
	match GameStates.player_level:
		2:
			bang_Sprite2D.visible = false
		_:
			pass
		
