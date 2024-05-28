extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.play_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/intro_video.tscn")

func _on_how_to_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/onboarding.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
