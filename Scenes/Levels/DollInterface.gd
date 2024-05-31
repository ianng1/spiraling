extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if %Doll_Hair.spriteIdx == 2 and %Doll_Eyes.spriteIdx == 3 and %Doll_Coat.spriteIdx == 4:
		visible = false
		$"../../../Level/ClickableDoll".is_interface_open = false
		$"../../../Level/ClickableDoll".is_opened = true
