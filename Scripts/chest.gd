extends AnimatedSprite2D

@export var object_scene: PackedScene = null


var is_mouse_on_chest: bool = false
var is_interface_open: bool = false
var is_opened: bool = false
var click_allowed = true
var show_clear_digits: bool = true
var code_entered: String = "" 
var last_num_pressed = -1
const SOLUTION = "0617"
var is_poster_open: bool = false


@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var tween = get_tree().create_tween()
@onready var poster = %poster
@onready var audio_player = $chest_open_player


# Called when the node enters the scene tree for the first time.
func _ready():
	name = "Chest"
	animation_player.play("idle")

func _mouse_on_box():
	is_mouse_on_chest = true
	
func _mouse_off_box():
	is_mouse_on_chest = false

func _open_box():
	is_opened = true
	%ChestInterface.visible = false
	%Lockbox.visible = false
	is_interface_open = false
	animation_player.play("open")
	audio_player.play()
	if poster:
		poster.visible = true
		is_poster_open = true
	GameStates.l1_box_opened = true

func _reset_keypad():
	show_clear_digits = true
	code_entered = ""
	last_num_pressed = -1
	
func _press_number_on_keypad(number):
	code_entered += str(number)
	last_num_pressed = number
	click_allowed = false
	$ClickCooldownTimer.start()


func _on_area_2d_2_input_event(viewport, event, shape_idx):
	if !(event is InputEventMouseButton) or event.button_index != MOUSE_BUTTON_LEFT:
		return
	if is_opened and poster:
		poster.visible = true
		is_poster_open = true
	elif not is_interface_open:
		%ChestInterface.visible = true
		%Lockbox.visible = true
		is_interface_open = true

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and is_interface_open:
		%ChestInterface.visible = false
		%Lockbox.visible = false
		is_interface_open = false
		_reset_keypad()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and is_poster_open:
		%poster.visible = false
		is_poster_open = false


func _on_area_2d_one_input_event(viewport, event, shape_idx):
	if click_allowed:
		show_clear_digits = false
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (len(code_entered) <= 4):
			_press_number_on_keypad(1)

func _on_area_2d_two_input_event(viewport, event, shape_idx):
	if click_allowed:
		show_clear_digits = false
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (len(code_entered) <= 4):
			_press_number_on_keypad(2)


func _on_area_2d_three_input_event(viewport, event, shape_idx):
	if click_allowed:
		show_clear_digits = false
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (len(code_entered) <= 4):
			_press_number_on_keypad(3)

func _on_area_2d_four_input_event(viewport, event, shape_idx):
	if click_allowed:
		show_clear_digits = false
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (len(code_entered) <= 4):
			_press_number_on_keypad(4)

func _on_area_2d_five_input_event(viewport, event, shape_idx):
	if click_allowed:
		show_clear_digits = false
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (len(code_entered) <= 4):
			_press_number_on_keypad(5)
	
func _on_area_2d_six_input_event(viewport, event, shape_idx):
	if click_allowed:
		show_clear_digits = false
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (len(code_entered) <= 4):
			_press_number_on_keypad(6)

func _on_area_2d_seven_input_event(viewport, event, shape_idx):
	if click_allowed:
		show_clear_digits = false
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (len(code_entered) <= 4):
			_press_number_on_keypad(7)

func _on_area_2d_eight_input_event(viewport, event, shape_idx):
	if click_allowed:
		show_clear_digits = false
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (len(code_entered) <= 4):
			_press_number_on_keypad(8)

func _on_area_2d_nine_input_event(viewport, event, shape_idx):
	if click_allowed:
		show_clear_digits = false
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (len(code_entered) <= 4):
			_press_number_on_keypad(9)
		
func _on_area_2d_zero_input_event(viewport, event, shape_idx):
	if click_allowed:
		show_clear_digits = false
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (len(code_entered) <= 4):
			_press_number_on_keypad(0)

func _on_area_2d_clear_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_reset_keypad()

func _on_area_2d_submit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if code_entered == SOLUTION:
			_open_box()
		else:
			_reset_keypad()

func _on_click_cooldown_timer_timeout():
	click_allowed = true

func _on_area_2d_poster_input_event(viewport, event, shape_idx):
	# Close poster
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and is_poster_open:
		%poster.visible = false
		is_poster_open = false
