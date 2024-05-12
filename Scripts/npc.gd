extends CharacterBody2D

# Reference: adaptedd from the tutorial from
# - https://www.youtube.com/watch?v=LMSbPkNgnWA
# - https://www.youtube.com/watch?v=qEwfi7_r9v8
# - Dialogue: https://www.youtube.com/watch?v=UhPFk8FSbd8

# NPC identifiers
# TODO: use param for different level so no need to recreate scripts
var level = "1"
var npc = "A_husband"

var dialogue_file = "res://Dialogue/npc_" + npc + ".dialogue"
var dialogue_level = "level" + level
var cur_state = IDLE
var is_mouse_hover = false
# Special movement or iteration if any.
var is_special_movement = false

enum {
	IDLE,
	SPECIAL_MOVE
}

func _ready():
	randomize()

func _process(delta):
	#print(get_viewport().get_mouse_position())
	if cur_state == IDLE:
		$AnimatedSprite2D.play("Idle")
	elif cur_state == SPECIAL_MOVE:
		# TODO: add any special movement if needed.
		pass

	if Input.is_action_just_pressed("chat") and is_mouse_hover:
		DialogueManager.show_example_dialogue_balloon(load(dialogue_file), dialogue_level)

# --------- SIGNALS ---------- #
# Detect whetehr the mouse is hover on NPC
func _on_chat_detection_area_2d_mouse_entered():
	is_mouse_hover = true

func _on_chat_detection_area_2d_mouse_exited():
	is_mouse_hover = false
