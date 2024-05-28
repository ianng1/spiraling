extends PointLight2D

var timer
var light_visible = false

var turn_on_flickering = false
var start_checking_turn_off = false
var revert_h = false
var target_wife_level = 2
var original_scale

@onready var player = %Player
@onready var wife = $"../../../Level/A_wife"

func _ready():
	self.visible = false
	original_scale = self.scale.x
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.5
	timer.start()
	timer.connect("timeout", self._on_timer_timeout)

func _on_timer_timeout() -> void:
	if turn_on_flickering:
		# Toggle on and off
		light_visible = !light_visible
		self.visible = light_visible
	else:
		self.visible = false

func _process(_delta):
	# Turn of flickering when the player go to the wife's position
	self.turn_of_at_wife()
	# light on the left.
	if revert_h:
		self.scale.x = -original_scale

func turn_of_at_wife():
	var play_x = player.position.x 
	var wife_x = wife.position.x
	var offset = 20
	if play_x > wife_x - offset and play_x < wife_x + offset and GameStates.player_level == target_wife_level:
		turn_on_flickering = false