extends Node2D

var freeze_player_movement = false
var action_cursor = preload("res://Assets/Images/action_cursor.png")
var idle_cursor = preload("res://Assets/Images/idle_cursor.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _test():
	pass

func _process(delta):
	if ($"Level/Chest".is_interface_open):
		freeze_player_movement = true
	else:
		freeze_player_movement = false

func change_to_action_cursor():
	Input.set_custom_mouse_cursor(action_cursor)
	
func change_to_idle_cursor():
	Input.set_custom_mouse_cursor(idle_cursor)
