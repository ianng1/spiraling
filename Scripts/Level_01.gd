extends Node2D

var freeze_player_movement = false
var max_level = 1

var action_cursor = preload("res://Assets/Images/action_cursor.png")
var idle_cursor = preload("res://Assets/Images/idle_cursor.png")
@onready var a_wife = $"Level/A_wife"
@onready var player = $Player
@onready var wife_bang_player = $"Level/ClickableDoll/WifeBangPlayer"
@onready var flicker_light = $UserInterface/GameUI/flickering_light
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _test():
	pass
	
func unlock_level1():
	max_level = 2
	GameStates.player_max_level = 2
	print("unlocked")
	
func unlock_level2():
	if GameStates.l2_doll_solved:
		return
	GameStates.l2_doll_solved = true
	max_level = 3
	wife_bang_player.play()
	a_wife.load_dialogue()
	GameStates.player_max_level = 3
	# Start light until talk to sibling
	flicker_light.turn_on_flickering = true
	flicker_light.target_level = 3
	flicker_light.cur_target = "B_sibling"

func _process(delta):
	if ($"Level/Chest".is_interface_open or $"Level/Chest".is_poster_open or 
	$"Level/Clock_Node2D".is_interface_open or $"UserInterface/GameUI/Map_Icon".is_map_open or
	$"UserInterface/GameUI/Help_Icon".is_help_open or $"Level/ClickableDoll".is_interface_open):
		freeze_player_movement = true
	else:
		freeze_player_movement = false
	
	if max_level == 2 && player:
		pass
		# TODO: go to level 2

func change_to_action_cursor():
	Input.set_custom_mouse_cursor(action_cursor)
	
func change_to_idle_cursor():
	Input.set_custom_mouse_cursor(idle_cursor)

