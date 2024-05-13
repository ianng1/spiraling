extends AnimatedSprite2D

@export var object_scene: PackedScene = null

var is_player_inside: bool = false
var is_locked_solved: bool = false
var is_opened: bool = false

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var tween = get_tree().create_tween()


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("idle")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and not is_opened:
		is_opened = true
		animation_player.play("open")
		print("chest was opened successfully")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_player_entered(player: CharacterBody2D) -> void:
	is_player_inside = true


func _on_area_2d_player_exited(player: CharacterBody2D) -> void:
	is_player_inside = false


func _drop_object() -> void:
	print("chest was opened successfully")
