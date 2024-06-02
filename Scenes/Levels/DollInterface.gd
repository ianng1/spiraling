extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameStates.l2_doll_solved:
		visible = false
		$"../../../Level/ClickableDoll".is_interface_open = false
		$"../../../Level/ClickableDoll".is_opened = true
