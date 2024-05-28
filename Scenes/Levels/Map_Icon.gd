extends Sprite2D

var hover_texture = preload("res://Assets/Images/hover_map.png")
var idle_texture = preload("res://Assets/Images/idle_map.png")
var freeze_player_movement = false
var is_map_open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if is_map_open:
		freeze_player_movement = true
	else:
		freeze_player_movement = false

func _on_area_2d_mouse_entered():
	self.texture = hover_texture



func _on_area_2d_mouse_exited():
	self.texture = idle_texture


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		get_node("/root/Level_01/UserInterface/GameUI/Map_Level_1").visible = true
		is_map_open = true
		# Set the node's visibility to true


func _on_area_2d_exit_input_event(viewport, event, shape_idx):
	if is_map_open and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		get_node("/root/Level_01/UserInterface/GameUI/Map_Level_1").visible = false
		is_map_open = false
