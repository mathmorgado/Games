extends Sprite
class_name PlayerTexture

export(NodePath) onready var animation = get_node(animation) as AnimationPlayer

func animate(direction: Vector2) -> void:
	verify_position(direction)
	horazintal_behavior(direction)


func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		flip_h = false	
	elif direction.x < 0: # Ignora o 0 para manter o flip para o mesmo lado
		flip_h = true


func horazintal_behavior(direction: Vector2) -> void:
	if direction.x != 0:
		animation.play("run")
	else:
		animation.play("idle")
