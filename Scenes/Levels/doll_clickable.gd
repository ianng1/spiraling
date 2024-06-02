extends Sprite2D

@export var object_scene: PackedScene = null

var is_interface_open: bool = false
var is_opened: bool = false

@onready var timer = get_node("/root/Level_01/Level/doll_clickable/DollClickCooldownTimer")

# Called when the node enters the scene tree for the first time.
func _ready():
	name = "Doll"

func _on_area_2d_input_event(viewport, event, shape_idx):
	if !(event is InputEventMouseButton) or event.button_index != MOUSE_BUTTON_LEFT:
		return
	if not is_interface_open and !GameStates.l2_doll_solved:
		%DollInterface.visible = true
		is_interface_open = true
		
func _on_area_2d_exit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and is_interface_open:
		%DollInterface.visible = false
		is_interface_open = false
