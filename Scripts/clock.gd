extends Node2D

# Reference: https://www.youtube.com/watch?v=ujwC0bz8iHQ

var hand_short 
var hand_short_degree
var hand_short_hover = false

var hand_long
var hand_long_degree
var hand_long_hover = false

var is_dragging = false
var success = false
var movement_delta : Vector2
var click_position : Vector2
var clock_hover = false

var clockwise_hover = false
var counter_clockwise_hover = false

# Elements to unlock when done.
@onready var bang_Sprite2D = $"../bang_Sprite2D_UI"

# Set up the hands to rotate.
func _ready():
	hand_short = get_node("clock_hand_short")
	hand_short_degree = int(hand_short.get_rotation_degrees())
	hand_long = get_node("clock_hand_long")
	hand_long_degree = int(hand_long.get_rotation_degrees())

# Rotate hands when user click on them.
func _process(_delta):
	if not is_dragging or success:
		return
	
	var degree_to_rotate = 12

	#if clock_hover:
	if counter_clockwise_hover:
		degree_to_rotate = -degree_to_rotate
	
	if counter_clockwise_hover or clockwise_hover:
		#var dir = 1 if int(hand_long_degree) % 360 > 180 else -1
		hand_short_degree += degree_to_rotate / 12
		hand_long_degree += degree_to_rotate
		hand_short.set_rotation_degrees(hand_short_degree)
		hand_long.set_rotation_degrees(hand_long_degree)
	

func _input(event):
	if success:
		return
	if Input.is_action_just_pressed("click") and "position" in event:
		click_position = event.position
		
	if event is InputEventMouseButton:
		if event.is_pressed():
			is_dragging = true
		else:
			is_dragging = false
	
	if is_dragging and "position" in event:
		movement_delta = click_position - event.position
		pass
			
	# Click instead of drag, reset.
	if Input.is_action_just_released("click"):
		is_dragging = false
		# Auto rotate to correct degree if close. Mod is not working with float,
		# so checking mod here and keep float actual degree for accuracy.
		var hand_short_deg_360 = int(hand_short_degree + (floor(abs(hand_short_degree/360)) + 1) * 360) % 360
		var hand_long_deg_360 = int(hand_long_degree + (floor(abs(hand_long_degree/360)) + 1) * 360) % 360
		if (
			125 < hand_short_deg_360
			and hand_short_deg_360 < 145
			and 75 < hand_long_deg_360
			and hand_long_deg_360 < 105
			):
			success = true
			
			hand_long.set_rotation_degrees(90)
			hand_short.set_rotation_degrees(135)
			print("Clock time correct. Bang unlocked")
			# Unlock for next.
			print(bang_Sprite2D)
			bang_Sprite2D.visible = true
			get_node("/root/Level_01/").unlock_level1()

# --------- SIGNALS ---------- #

func _on_clock_area_2d_mouse_entered():
	clock_hover = true

func _on_clock_area_2d_mouse_exited():
	clock_hover = false

func _on_counterclockwise_area_2d_mouse_entered():
	clockwise_hover = true

func _on_counterclockwise_area_2d_mouse_exited():
	clockwise_hover = false

func _on_clockwise_area_2d_mouse_entered():
	counter_clockwise_hover = true

func _on_clockwise_area_2d_mouse_exited():
	counter_clockwise_hover = false
