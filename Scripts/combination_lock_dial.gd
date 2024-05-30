extends CharacterBody2D

# Reference: adaptedd from the tutorial from
# - https://www.youtube.com/watch?v=LMSbPkNgnWA
# - https://www.youtube.com/watch?v=qEwfi7_r9v8
# Dialogue:
# - https://www.youtube.com/watch?v=UhPFk8FSbd8
# - doc: https://github.com/nathanhoad/godot_dialogue_manager

# NPC, level, and dialogue identifiers. These will be reset
# based on the metadata to match the correct npc and level.
var id
var action_cursor = preload("res://Assets/Images/action_cursor.png")
var idle_cursor = preload("res://Assets/Images/idle_cursor.png")
var cur_state = 0
var is_mouse_hover = false
var display_clear_digits = true
var position_to_write: int = 1
var current_code: String = ""
var number_to_write: int
var image_to_load: String = ""
var test = ""
# Special movement or iteration if any.
var is_special_movement = false
@onready var sprite2d = get_node("Sprite2D")
enum {
	IDLE,
	SPECIAL_MOVE # Currently not in use.
}

func _ready():
	randomize()
	
	# Set npc and level based on metadata.

func _process(delta):
	#print(get_viewport().get_mouse_position())
	#if cur_state == IDLE:
		#$AnimatedSprite2D.play("Idle")
	#elif cur_state == SPECIAL_MOVE:
	display_clear_digits = get_node("/root/Level_01/Level/Chest").show_clear_digits
	if display_clear_digits:
		#print("clear digits displayed")
		#position_to_write = len(get_node("/root/Level_01/Chest").code_entered)
		#if (position_to_write == 0):
			#print("SUCCESSFULLY CLEARED")
		sprite2d.set_texture(load("res://Assets/Textures/lock_digits/cleared.png"))
	else:
		position_to_write = len(get_node("/root/Level_01/Level/Chest").code_entered)
		#test = get_node("/root/Level_01/Chest").code_entered
		#print(test)
		number_to_write = get_node("/root/Level_01/Level/Chest").last_num_pressed
		if number_to_write != -1:
			image_to_load = "res://Assets/Textures/lock_digits/" + str(number_to_write) + ".png"
			var lockbox_number_path = "/root/Level_01/UserInterface/GameUI/Lockbox/NumberPad/"
			if (position_to_write == 1):
				get_node(lockbox_number_path + "Number1/Sprite2D").set_texture(load(image_to_load))
			elif (position_to_write == 2):
				get_node(lockbox_number_path + "Number2/Sprite2D").set_texture(load(image_to_load))
			elif (position_to_write == 3):
				get_node(lockbox_number_path + "Number3/Sprite2D").set_texture(load(image_to_load))
			else:
				get_node(lockbox_number_path + "Number4/Sprite2D").set_texture(load(image_to_load))


		#number_to_write = get_node("/root/Level_01/Chest").last_num_pressed
		#if (position == 1):
			#get_node("/root/Level_01/Chest/Lockbox/NumberPad/Number1/Sprite2D").set_texture(load("res://Assets/Textures/lock_digits/" + str(number_to_write) + ".png"))

# --------- SIGNALS ---------- #
# Detect whetehr the mouse is hover on NPC


