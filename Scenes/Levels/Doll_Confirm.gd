extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_doll_area_2d_confirm_mouse_entered():
	modulate = "#cf0000"
	GameStates.set_action_cursor()


func _on_doll_area_2d_confirm_mouse_exited():
	modulate = "#ffffff"
	GameStates.set_idle_cursor()


func _on_doll_area_2d_confirm_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if %Doll_Eyes.spriteIdx == 3 and %Doll_Hair.spriteIdx == 2 and %Doll_Coat.spriteIdx == 4:
					get_node("/root/Level_01/").unlock_level2()
					GameStates.l2_doll_solved = true
		else:
			%Doll_Hair.modulate = "#FFFFFF"
			%Doll_Eyes.modulate = "#FFFFFF"
			%Doll_Coat.modulate = "#FFFFFF"
