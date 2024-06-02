extends PointLight2D

var timer
var light_visible = false

var turn_on_flickering = false
var start_checking_turn_off = false
var revert_h = false
var target_wife_level = 2
var original_scale
var prev_player_x

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
	prev_player_x = player.position.x 

func _on_timer_timeout() -> void:
	if turn_on_flickering:
		# Toggle on and off
		light_visible = !light_visible
		self.visible = light_visible
	else:
		self.visible = false

func _process(_delta):
	# Revert flickering to direct the player go to the wife's position
	self.revert_at_wife()
	# light on the left.
	if revert_h:
		self.scale.x = -original_scale
	else:
		self.scale.x = original_scale

# Check whether the player is talking to the correct wife
# If so, turn off lightening
func check_and_turn_off_at_wife():
	if GameStates.player_level == target_wife_level:
		turn_on_flickering = false
	
# revert lighting to direct to wife.	
func revert_at_wife():
	if wife == null or player == null:
		return
	if not prev_player_x:
		prev_player_x = player.position.x 
		return
	var play_x = player.position.x 
	var wife_x = wife.position.x
	
	if GameStates.player_level == target_wife_level:
		if prev_player_x < wife_x and play_x > wife_x:
			# Direct player to go left
			revert_h = true
		elif prev_player_x > wife_x and play_x < wife_x:
			# Direct player to go right
			revert_h = false
	prev_player_x = play_x

# Not used in current version, decide whether to remove after playtesting
# Turn off lighting when walk to wife.
func turn_of_at_wife():
	var play_x = player.position.x 
	var wife_x = wife.position.x
	var offset = 20
	if play_x > wife_x - offset and play_x < wife_x + offset and GameStates.player_level == target_wife_level:
		turn_on_flickering = false
