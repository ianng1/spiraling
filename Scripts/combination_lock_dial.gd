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

var cur_state = 0
var is_mouse_hover = false
# Special movement or iteration if any.
var is_special_movement = false
@onready var sprite2d = get_node("Sprite2D")
enum {
	IDLE,
	SPECIAL_MOVE # Currently not in use.
}

func _ready():
	print("Randomizing")
	randomize()
	
	# Set npc and level based on metadata.

func _process(delta):
	#print(get_viewport().get_mouse_position())
	#if cur_state == IDLE:
		#$AnimatedSprite2D.play("Idle")
	#elif cur_state == SPECIAL_MOVE:
		## TODO: add any special movement if needed.
		pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and is_mouse_hover:
		cur_state = (cur_state + 1) % 10
		sprite2d.set_texture(load("res://Assets/Textures/lock_digits/" + str(cur_state) + ".png"))
		print("res://Assets/Textures/lock_digits/" + str(cur_state) + ".png")
# --------- SIGNALS ---------- #
# Detect whetehr the mouse is hover on NPC


func _on_area_2d_mouse_entered():
	print("entering")
	is_mouse_hover = true


func _on_area_2d_mouse_exited():
	print("leaving")
	is_mouse_hover = false
