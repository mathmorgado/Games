extends CharacterBody2D


const SPEED = 200
const JUMP_FORCE = -300.0

var gravity = 950
@onready var animation := $anim as AnimatedSprite2D


func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		animation.play("jump")
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y += JUMP_FORCE
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		
		if is_on_floor():
			animation.play("run")
			
	else:
		velocity.x = direction
		if is_on_floor():
			animation.play("idle")
		
	move_and_slide()
	


