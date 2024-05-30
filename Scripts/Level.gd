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
@onready var clickable_doll = %ClickableDoll
@onready var doll_map_icon = $"../UserInterface/GameUI/Map_Level_1/doll"
@onready var wife = $A_wife
@onready var wife_map_icon = $"../UserInterface/GameUI/Map_Level_1/npc1"

func _ready():
	pass

func _process(_delta):
	update_items_positions()
	update_scene()

# Move nodes to left and rights when they are outsides the scene for looping.
func update_items_positions():
	if level == null:
		return
	
	# Move items in the screen to left and right
	for node in level.get_children():
		var screen_pos = get_viewport().canvas_transform * node.global_position
		var viewport_x = get_viewport().size.x

		# The actual drawing of jail is offset from the position of tilemap.
		if node.get_name() in ["617scratchmark"]:
			screen_pos.x += jail_offset
		
		# Move assets to left and right.
		if screen_pos.x < -canvas_size/2:
			# hide wife at level3
			if (
				not (GameStates.player_level >= 2 and node.get_name() == "A_wife") 
				or screen_pos.x < -2 * canvas_size
				or GameStates.player_max_level != 3
			):
				node.position.x += canvas_size
		# Need to adjust buffer size by window scale
		elif screen_pos.x > canvas_size/2:
			node.position.x -= canvas_size
			
# Update items in the scene for each levels.
func update_scene():
	match GameStates.player_level:
		3: 
			clickable_doll.visible = true
			doll_map_icon.visible = true
			wife.visible = false
			wife_map_icon.visible = false
		2:
			clickable_doll.visible = true
			doll_map_icon.visible = true
			wife.visible = true
			wife_map_icon.visible = true
		1:
			clickable_doll.visible = false
			doll_map_icon.visible = false
			wife.visible = true
			wife_map_icon.visible = true
		_:
			# default, should not be here.
			pass
		
