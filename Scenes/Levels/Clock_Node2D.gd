extends Node2D

var is_interface_open: bool = false
var is_solved: bool = false

@onready var clock = %clock_node2D_UI
@onready var cur_clock_hand_short = $"clock_hand_short"
@onready var cur_clock_hand_long = $"clock_hand_long"
@onready var clock_hand_short = $"../../UserInterface/GameUI/clock_node2D_UI/clock_hand_short"
@onready var clock_hand_long = $"../../UserInterface/GameUI/clock_node2D_UI/clock_hand_long"

func _ready():
	pass

func _process(delta):
	cur_clock_hand_long.set_rotation_degrees(clock_hand_long.get_rotation_degrees())
	cur_clock_hand_short.set_rotation_degrees(clock_hand_short.get_rotation_degrees())
	if clock.success:
		cur_clock_hand_long.set_rotation_degrees(90)
		cur_clock_hand_short.set_rotation_degrees(135)
		_close_clock()

func _close_clock():
	clock.visible = false
	is_interface_open = false
	
func _on_area_2d_clock_input_event(viewport, event, shape_idx):
	if !(event is InputEventMouseButton) or event.button_index != MOUSE_BUTTON_LEFT:
		return
	elif not is_interface_open and not clock.success:
		clock.visible = true
		is_interface_open = true


func _on_clock_exit_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and is_interface_open:
		_close_clock()
