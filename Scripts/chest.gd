extends AnimatedSprite2D

@export var object_scene: PackedScene = null

var is_player_inside: bool = false
var is_locked_solved: bool = false
var is_mouse_on_chest: bool = false
var is_interface_open: bool = false
var is_opened: bool = false
var code_entered: int = 0

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var tween = get_tree().create_tween()


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("idle")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and is_locked_solved and is_mouse_on_chest:
		is_opened = true
		animation_player.play("open")
		print("chest was opened successfully")
		

func _open_box():
	is_opened = true
	if $ChestInterface:
		$ChestInterface.visible = false
	if $Lockbox:
		$Lockbox.visible = false
	is_interface_open = false
	animation_player.play("open")
	print("chest was opened successfully")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("/root/Level_01/Chest/Lockbox/NumberPad"):
		code_entered = get_node("/root/Level_01/Chest/Lockbox/NumberPad").current_code
	if code_entered == 0617 and is_interface_open:
		_open_box()

func _mouse_on_box():
	is_mouse_on_chest = true
	
	
func _mouse_off_box():
	is_mouse_on_chest = false


func _on_area_2d_player_entered(player: CharacterBody2D) -> void:
	is_player_inside = true


func _on_area_2d_player_exited(player: CharacterBody2D) -> void:
	is_player_inside = false


func _drop_object() -> void:
	print("chest was opened successfully")


func _on_area_2d_2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not is_interface_open:
		$ChestInterface.visible = true
		$Lockbox.visible = true
		is_interface_open = true

		


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and is_interface_open:
		$ChestInterface.visible = false
		$Lockbox.visible = false
		is_interface_open = false


