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
@onready var level_global = $"../../Level_01"

func _ready():
	pass

func _process(_delta):
	if level == null:
		return

	var level_right = 1
	if level_global:
		level_right = level_global.max_level
	var level_left = max(level_right - 1, 1)
	level_right = str(level_right)
	level_left = str(level_left)
	
	#max_level
	# Move nodes to left and rights when they are outsides the scene.
	for node in level.get_children():
		var screen_pos = get_viewport().canvas_transform * node.global_position
		var viewport_x = get_viewport().size.x

		# The actual drawing of jail is offset from the position of tilemap.
		if node.get_name() in ["617scratchmark"]:
			screen_pos.x += jail_offset
		if screen_pos.x < -200:
			if node.name in NpcStates.npc_levels:
				NpcStates.npc_levels[node.name] = str(level_right)
			node.position.x += canvas_size
		# Need to adjust buffer size by window scale
		elif screen_pos.x > get_viewport().size.x + 400:
			# Update level for npcs
			if node.name in NpcStates.npc_levels:
				NpcStates.npc_levels[node.name] = str(level_left)
			node.position.x -= canvas_size
