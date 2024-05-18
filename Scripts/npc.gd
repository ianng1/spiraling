extends CharacterBody2D

# Reference: adaptedd from the tutorial from
# - https://www.youtube.com/watch?v=LMSbPkNgnWA
# - https://www.youtube.com/watch?v=qEwfi7_r9v8
# Dialogue:
# - https://www.youtube.com/watch?v=UhPFk8FSbd8
# - doc: https://github.com/nathanhoad/godot_dialogue_manager

# NPC, level, and dialogue identifiers. These will be reset
# based on the metadata to match the correct npc and level.
var level
var npcId
var dialogue_file
var dialogue_level
# Whether the dialogue is completed at least once 
# on each level.
var dialogue_completed = {}

var cur_state = IDLE
var is_mouse_hover = false
# Special movement or iteration if any.
var is_special_movement = false

# The NPC related to puzzles on each levels
var npc_clues = {
	"1": ["C_kidnapped"],
}
# Whether the current level is unlocked.
var level_unlocked = false
var repeat_dialogue_id = "repeat"

@onready var level_globals = get_node("/root/Level_01")

enum {
	IDLE,
	SPECIAL_MOVE # Currently not in use.
}

func _ready():
	randomize()
	# Set npc and level based on metadata.
	level = get_meta("level")
	npcId = get_meta("npcId")
	dialogue_file = "res://Dialogue/npc_" + npcId + ".dialogue"
	dialogue_level = "level" + level

func _process(_delta):
	if level_globals.freeze_player_movement:
		return
	
	# Some NPC will have dialogue different before orafter the next level is unlocked.
	NpcStates.level_unlocked[npcId] = level_globals.max_level > int(level)
	print(NpcStates.level_unlocked)
	
	if cur_state == IDLE:
		$AnimatedSprite2D.play("Idle")
	elif cur_state == SPECIAL_MOVE:
		# TODO: add any special movement if needed.
		pass
	
	if Input.is_action_just_pressed("click") and is_mouse_hover and level != null:
		load_dialogue()

# Load the dialogue for the NPC.
func load_dialogue():
	# Check whether the full dialogue is played at least once before.
	var completed_dialogue = false
	if level in dialogue_completed and dialogue_completed[level]:
		completed_dialogue = true
	
	# Only play the full dialogue for NPCs related to the puzzle
	# or whose dialogue is not played before.
	if (not npcId in npc_clues[level]) and completed_dialogue:
		DialogueManager.show_example_dialogue_balloon(load(dialogue_file), repeat_dialogue_id)
	else:
		DialogueManager.show_example_dialogue_balloon(load(dialogue_file), dialogue_level)
		dialogue_completed[level] = true

# --------- SIGNALS ---------- #
# Detect whetehr the mouse is hover on NPC
func _on_chat_detection_area_2d_mouse_entered():
	is_mouse_hover = true

func _on_chat_detection_area_2d_mouse_exited():
	is_mouse_hover = false
