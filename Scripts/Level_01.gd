extends Node2D

var next_scene = "res://Scenes/Levels/Level_02.tscn"

var freeze_player_movement = false
var unlocked = false

var action_cursor = preload("res://Assets/Images/action_cursor.png")
var idle_cursor = preload("res://Assets/Images/idle_cursor.png")

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _test():
	pass
	
func unlock_next_level():
	unlocked = true

func _process(delta):
	if ($"Level/Chest".is_interface_open):
		freeze_player_movement = true
	else:
		freeze_player_movement = false
	
	if unlocked && player:
		print(player.global_position.x)
		get_tree().change_scene_to_file(next_scene)


func change_to_action_cursor():
	Input.set_custom_mouse_cursor(action_cursor)
	
func change_to_idle_cursor():
	Input.set_custom_mouse_cursor(idle_cursor)
