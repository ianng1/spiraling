extends Node

@onready var music_player = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(music_player)
	var music = preload("res://Assets/Music/backgroundmusic.mp3")  # Ensure you use the correct path to your music file
	if music is AudioStream:
		music.set_loop(true)
	music_player.stream = music


func play_music():
	if not music_player.playing:
		music_player.play()

func stop_music():
	if music_player.playing:
		music_player.stop()
