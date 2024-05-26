extends Sprite2D

var hover_texture = preload("res://Assets/Images/help_icon_hover.png")
var idle_texture = preload("res://Assets/Images/help_icon.png")
var freeze_player_movement = false
var is_help_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_exit_map_input_event(viewport, event, shape_idx):
	if is_help_open and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		get_node("/root/Level_01/UserInterface/GameUI/Help").visible = false
		is_help_open = false


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		get_node("/root/Level_01/UserInterface/GameUI/Help").visible = true
		is_help_open = true


func _on_area_2d_mouse_entered():
	self.texture = hover_texture


func _on_area_2d_mouse_exited():
	self.texture = idle_texture
