extends Sprite2D



#var sprites = [preload("res://Assets/doll/grey_eyes.png"), preload("res://Assets/doll/black_eyes.png"), preload("res://Assets/doll/green_eyes.png"), preload("res://Assets/doll/blue_eyes.png"), preload("res://Assets/doll/red_eyes.png")]
var sprites = ["#FFFFFF", "#FFE844", "#FF1212", "#126FFF", "#9E12FF"]
var spriteIdx = 0


@onready var timer = get_node("/root/Level01/UserInterface/GameUI/DollInterface/DollClickCooldownTimer")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (%DollClickCooldownTimer.time_left == 0) and GameStates.l2_doll_solved == false:
			spriteIdx += 1
			spriteIdx %= 5
			modulate = sprites[spriteIdx]
			%DollClickCooldownTimer.start()

func _on_area_2d_right_eye_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (%DollClickCooldownTimer.time_left == 0) and GameStates.l2_doll_solved == false:
			spriteIdx += 1
			spriteIdx %= 5
			modulate = sprites[spriteIdx]
			%DollClickCooldownTimer.start()

func _on_area_2d_left_eye_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (%DollClickCooldownTimer.time_left == 0) and GameStates.l2_doll_solved == false:
			spriteIdx += 4
			spriteIdx %= 5
			modulate = sprites[spriteIdx]
			%DollClickCooldownTimer.start()
