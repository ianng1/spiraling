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

var cur_state = IDLE
var is_mouse_hover = false
# Special movement or iteration if any.
var is_special_movement = false

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

func _process(delta):
	#print(get_viewport().get_mouse_position())
	if cur_state == IDLE:
		$AnimatedSprite2D.play("Idle")
	elif cur_state == SPECIAL_MOVE:
		# TODO: add any special movement if needed.
		pass

	if(!get_node("/root/Level_01").freeze_player_movement):
		if Input.is_action_just_pressed("click") and is_mouse_hover and level != null:
			DialogueManager.show_example_dialogue_balloon(load(dialogue_file), dialogue_level)

# --------- SIGNALS ---------- #
# Detect whetehr the mouse is hover on NPC
func _on_chat_detection_area_2d_mouse_entered():
	is_mouse_hover = true

func _on_chat_detection_area_2d_mouse_exited():
	is_mouse_hover = false
