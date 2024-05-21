extends Node

# --------- VARIABLES ---------- #

var roration_degree = 0
@onready var level = %Level
@onready var player = %Player
@onready var redDot = $playerDot_Sprite2D

# --------- BUILT-IN FUNCTIONS ---------- #

func _process(_delta):
	movement()
	
# --------- CUSTOM FUNCTIONS ---------- #

func movement():
	# Move Red dot
	roration_degree =  get_player_pos_in_canvas()
	if redDot != null:
		redDot.set_rotation_degrees(roration_degree)

func get_player_pos_in_canvas():
	if player == null or level == null:
		return 0 
	var player_pos = player.global_position.x
	var canvas_size = level.canvas_size
	var player_canvas_ratio = player_pos / canvas_size * 360
	return int(player_canvas_ratio + (floor(abs(player_canvas_ratio/360)) + 1) * 360) % 360
