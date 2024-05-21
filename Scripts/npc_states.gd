extends Node

# The level where each NPC is at.
var levels = {
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
