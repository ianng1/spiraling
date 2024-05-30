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
	"2": ["A_wife"],
	"3": []
}
# Whether the current level is unlocked.
var level_unlocked = false
var repeat_dialogue_id = "repeat"

@onready var level_globals = get_node("/root/Level_01")
@onready var flicker_light = $"../../UserInterface/GameUI/flickering_light"

enum {
	IDLE,
	SPECIAL_MOVE # Currently not in use.
}

func _ready():
	randomize()
	# Set npc and level based on metadata.
	#level = get_meta("level")
	npcId = get_meta("npcId")
	dialogue_file = "res://Dialogue/npc_" + npcId + ".dialogue"

func _process(_delta):
	if level_globals.freeze_player_movement:
		return
	
	# Update level from status
	level = str(GameStates.player_level)
	# Some NPC will have dialogue different before orafter the next level is unlocked.
	GameStates.level_unlocked[npcId] = level_globals.max_level > int(level)
	
	if cur_state == IDLE:
		$AnimatedSprite2D.play("Idle")
	elif cur_state == SPECIAL_MOVE:
		# TODO: add any special movement if needed.
		pass
	
	if Input.is_action_just_pressed("click") and is_mouse_hover and level != null:
		load_dialogue()

# Load the dialogue for the NPC.
func load_dialogue():
	# Not load a new dialogue if the previous one is active.
	if GameStates.active_dialogue_balloon != null:
		return
	
	# Check whether the full dialogue is played at least once before.
	var completed_dialogue = false
	if level in dialogue_completed and dialogue_completed[level]:
		completed_dialogue = true
	
	# Only play the full dialogue for NPCs related to the puzzle
	# or whose dialogue is not played before.
	dialogue_level = "floor" + level
	if (not npcId in npc_clues[str(level_globals.max_level)]) and completed_dialogue:
		var title = dialogue_level + "_" + repeat_dialogue_id
		GameStates.active_dialogue_balloon = DialogueManager.show_dialogue_balloon(load(dialogue_file), title)
	else:
		GameStates.active_dialogue_balloon = DialogueManager.show_dialogue_balloon(load(dialogue_file), dialogue_level)
		dialogue_completed[level] = true
	
	self.start_or_stop_light_flicker()
	
func start_or_stop_light_flicker():
	# Turn off the lights after the player talk to the expected wife
	if npcId == "A_wife":
		flicker_light.check_and_turn_off_at_wife()
	
	# Start light flickering when player talk to level 2 wife
	if npcId == "A_wife" and level == "2" and !GameStates.l2_doll_solved:
		flicker_light.turn_on_flickering = true
		flicker_light.target_wife_level = 1
		flicker_light.revert_h = true


# --------- SIGNALS ---------- #
# Detect whetehr the mouse is hover on NPC
func _on_chat_detection_area_2d_mouse_entered():
	is_mouse_hover = true

func _on_chat_detection_area_2d_mouse_exited():
	is_mouse_hover = false
