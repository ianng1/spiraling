extends Node2D

var freeze_player_movement = false
var max_level = 1

var action_cursor = preload("res://Assets/Images/action_cursor.png")
var idle_cursor = preload("res://Assets/Images/idle_cursor.png")

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _test():
	pass
	
func unlock_level1():
	max_level = 2

func _process(delta):
	if ($"Level/Chest".is_interface_open):
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
