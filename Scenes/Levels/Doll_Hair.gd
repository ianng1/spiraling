extends Sprite2D



var sprites = [preload("res://Assets/doll/red_hair.png"), preload("res://Assets/doll/blue_hair.png"), preload("res://Assets/doll/brown_hair.png"), preload("res://Assets/doll/green_hair.png")]
var spriteIdx = 0

@onready var timer = get_node("/root/Level_01/Level/doll_clickable/DollClickCooldownTimer")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (%DollClickCooldownTimer.time_left == 0 and GameStates.l2_doll_solved == false):
			spriteIdx += 1
			spriteIdx %= 4
			texture = sprites[spriteIdx]
			%DollClickCooldownTimer.start()
			if spriteIdx == 2 and %Doll_Eyes.spriteIdx == 3:
				GameStates.l2_doll_solved = true
				get_node("/root/Level_01/").unlock_level2()
