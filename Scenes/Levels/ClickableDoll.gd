extends Sprite2D

var is_interface_open: bool = false
var is_opened: bool = false

# @onready var timer = get_node("/root/Level_01/UserInterface/GameUI/DollInterface/DollClickCooldownTimer")
@onready var interface =  get_node("/root/Level_01/UserInterface/GameUI/DollInterface")
@onready var hair = $"../../UserInterface/GameUI/DollInterface/Doll_Hair"
@onready var eyes = $"../../UserInterface/GameUI/DollInterface/Doll_Eyes"
@onready var coat = $"../../UserInterface/GameUI/DollInterface/Doll_Coat"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_area_2d_input_event(viewport, event, shape_idx):
	if !(event is InputEventMouseButton) or event.button_index != MOUSE_BUTTON_LEFT:
		return
	if not is_interface_open and not GameStates.l2_doll_solved:
		interface.visible = true
		is_interface_open = true
		hair.modulate = "#FFFFFF"
		eyes.modulate = "#FFFFFF"
		coat.modulate = "#FFFFFF"
		
func _on_area_2d_exit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and is_interface_open:
		interface.visible = false
		is_interface_open = false

func _on_area_2d_mouse_entered():
	if not is_opened:
		GameStates.set_action_cursor()

func _on_area_2d_mouse_exited():
	GameStates.set_idle_cursor()
