extends Node

var npc_names = [
	"A_husband",
	"A_wife",
	"B_sibling",
	"C_kidnapped",
	"D_phych",
]

# The level where each NPC is at.
var npc_levels = {
	"A_husband": 1,
	"A_wife": 1,
	"B_sibling": 1,
	"C_kidnapped": 1,
	"D_phych": 1,
}

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
