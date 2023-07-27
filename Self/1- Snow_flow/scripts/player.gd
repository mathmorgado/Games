extends CharacterBody2D

const SPEED = 150.0
const JUMP_FORCE = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1000
var is_jumping: bool = false
var knockback_vector := Vector2.ZERO

@export var player_life: int = 10

@onready var animation := $anim as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D
@onready var ray_right := $ray_right as RayCast2D
@onready var ray_left := $ray_left as RayCast2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true

	elif is_on_floor():
		is_jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction

		if !is_jumping:
			animation.play("run")

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")
		
	if is_jumping:
		animation.play("jump")

	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	
	move_and_slide()


func _on_hurtbox_body_entered(body):
#	if body.is_in_group("enemies"):
	if player_life < 0:
		queue_free()
	else:
		if ray_right.is_colliding():
			take_damege(Vector2(-200, -200))
			
		elif ray_left.is_colliding():
			take_damege(Vector2(200, -200))

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path
	

func take_damege(knockback_force := Vector2.ZERO, duration := 0.25):
	player_life -= 1
	
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
	
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		animation.modulate = Color(1, 0, 0, 1)
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)
