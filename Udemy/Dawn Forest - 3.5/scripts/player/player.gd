extends KinematicBody2D
class_name Player

export(int) var speed
export(int) var jump_speed
export(int) var player_gravity

onready var player_sprite: Sprite = get_node("texture")

var velocity: Vector2 #(150, 150
var jump_count: int = 0
var landing: bool = false

func _physics_process(delta: float):
	horizontal_movement_env()
	vertival_movement_env()

	gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	player_sprite.animate(velocity)


func horizontal_movement_env() -> void:
	var input_direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = input_direction * speed


func vertival_movement_env() -> void:
	if is_on_floor():
		jump_count = 0


	if Input.is_action_just_pressed("ui_select") and jump_count < 2:
		jump_count += 1
		velocity.y = jump_speed


func gravity(delta: float) -> void:
	velocity.y += delta * player_gravity
	if velocity.y >= player_gravity:
		velocity.y = player_gravity
