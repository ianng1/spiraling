extends BaseDialogueTestScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		# Load dialogue balloon
	var dialogue_balloon = load("res://Scenes/dialogue_balloon/balloon.tscn").instantiate()
	get_tree().current_scene.add_child(dialogue_balloon)
	dialogue_balloon.start(resource, title)
