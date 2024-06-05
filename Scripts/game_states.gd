extends Node
# This file contains global states and functions
# TODO: rename the file to game globals if have time.

var flicker_light_path = "Level_01/UserInterface/GameUI/flickering_light"

# Level related states
var l1_box_opened = false
var l2_doll_solved = false
var l3_step = 0
var l3_dialogue_solved = false

var l3_ordering = [3, 1, 2, 3, 2, 1, 3]


var npc_names = [
	"A_husband",
	"A_wife",
	"B_sibling",
	"C_kidnapped",
	"D_phych",
]

# The dialogue balloon in screen
var active_dialogue_balloon

# The floor that the player is at and the maximal floor he can go to.
# TODO: clearer naming when not need to worry about merge conflict
var player_level = 1
var player_max_level = 1
var player_movement_freeze = false

# Whether the level where each NPC are is unlocked.
var level_unlocked = {
	"A_husband": false,
	"A_wife": false,
	"B_sibling": false,
	"C_kidnapped": false,
	"D_phych": false,
}

# cursoe images
var action_cursor = preload("res://Assets/Images/action_cursor.png")
var idle_cursor = preload("res://Assets/Images/idle_cursor.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func unlock_level3():
	player_max_level = 4
	var flicker_light = get_tree().root.get_node("Level_01/UserInterface/GameUI/flickering_light")
	flicker_light.turn_on_flickering = true
	flicker_light.target_level = 4
	flicker_light.cur_target = "A_wife"
	print("Level 3 clear.")
	
func reset_level3():
	var flicker_light = get_tree().root.get_node("Level_01/UserInterface/GameUI/flickering_light")
	flicker_light.turn_on_flickering = true
	flicker_light.target_level = 3
	flicker_light.cur_target = "B_sibling"
	
func set_action_cursor():
	Input.set_custom_mouse_cursor(action_cursor)

func set_idle_cursor():
	Input.set_custom_mouse_cursor(idle_cursor)

