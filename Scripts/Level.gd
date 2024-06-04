extends Node2D

# Reference: 
# - https://www.reddit.com/r/godot/comments/16fy52m/check_whether_node_on_right_side_of_viewport/
# - https://www.reddit.com/r/godot/comments/40cm3w/looping_through_all_children_and_subchildren_of_a/

# Default configs, need to change when scene width is changed.
var canvas_size = 3260
var stretch_scale = 2
# Offset jail from tilemap position.
var jail_offset = 2013
var env_light_flicker_times = 0

# Level related items to show or hide.
@onready var clickable_doll = %ClickableDoll
@onready var doll_map_icon = $"../UserInterface/GameUI/Map_Level_1/doll"
@onready var wife = $A_wife
@onready var wife_map_icon = $"../UserInterface/GameUI/Map_Level_1/npc1"
# Variables for lighting to change to final screens
@onready var env_light = $"../CanvasModulate"
@onready var player_point_light = $"../Player/PointLight2D"
@onready var player_directional_light = $"../Player/PointLight2D2"
@onready var level_two_painting = $level_two_painting
@onready var level_three_painting = $level_three_painting
@onready var spider_web = $spider_web
@onready var tv_level_two = $"tv-level-two"
@onready var tv_level_three = $"tv-level-three"
@onready var wallscratches_one = $"wall-scratches"
@onready var wallscratches_two = $"wall-scratches2"
@onready var moving_spider = $"moving-spider"


func _ready():
	pass

func _process(_delta):
	update_items_positions()
	if name != "Level_final_scene":
		spider_web.play()
		tv_level_two.play()
		tv_level_three.play()
		moving_spider.play()
		# Update leveling when going left and right on first 3 levels.
		update_scene()

# Move nodes to left and rights when they are outsides the scene for looping.
func update_items_positions():
	# Move items in the screen to left and right
	for node in get_children():
		if "timer" in node.name:
			continue
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

func start_flicker_env_light():
	# Timer for next flickering
	print("start triggered")
	env_light_flicker_times += 1
	env_light.color = "#000000"
	player_point_light.visible = false
	player_directional_light.visible = false
	# Start the timer.
	var timer = Timer.new()
	add_child(timer)
	timer.name = "timer"
	timer.wait_time = 0.1
	timer.start()
	timer.connect("timeout", self.flicker_env_light_to_final)

func flicker_env_light_to_final():
	if env_light_flicker_times <= 10:
		if env_light.visible:
			env_light.visible = false
		else:
			env_light.visible = true
			env_light_flicker_times += 1
	else:
		get_tree().change_scene_to_file("res://Scenes/last_level_video.tscn")

# Update items in the scene for each levels.
func update_scene():
	match GameStates.player_level:
		4:
			if env_light_flicker_times == 0:
				start_flicker_env_light()
		3: 
			clickable_doll.visible = true
			doll_map_icon.visible = true
			wife.visible = false
			wife_map_icon.visible = false
			level_two_painting.visible = false
			tv_level_two.visible = false
			level_three_painting.visible = true
			tv_level_three.visible = true
			wallscratches_one.visible = true
			wallscratches_two.visible = true
			moving_spider.visible = true
		2:
			clickable_doll.visible = true
			doll_map_icon.visible = true
			wife.visible = true
			wife_map_icon.visible = true
			level_two_painting.visible = true
			level_three_painting.visible = false
			tv_level_two.visible = true
			tv_level_three.visible = false
			wallscratches_one.visible = true
			wallscratches_two.visible = false
			moving_spider.visible = true
		1:
			clickable_doll.visible = false
			doll_map_icon.visible = false
			wife.visible = true
			wife_map_icon.visible = true
			level_two_painting.visible = false
			level_three_painting.visible = false
			tv_level_two.visible = false
			tv_level_three.visible = false
			wallscratches_one.visible = false
			wallscratches_two.visible = false
			moving_spider.visible = false
		_:
			# default, should not be here.
			pass
		
