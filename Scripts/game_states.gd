extends Node

# Level related states
var l1_box_opened = false

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

# Whether the level where each NPC are is unlocked.
var level_unlocked = {
	"A_husband": false,
	"A_wife": false,
	"B_sibling": false,
	"C_kidnapped": false,
	"D_phych": false,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
