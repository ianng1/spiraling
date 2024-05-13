extends AnimatedSprite2D

@export var object_scene: PackedScene = null

var is_player_inside: bool = false
var is_locked_solved: bool = false
var is_opened: bool = false

@onready var animationplayer: AnimationPlayer = get_node("AnimationPlayer")
@onready var tween = get_tree().create_tween()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
