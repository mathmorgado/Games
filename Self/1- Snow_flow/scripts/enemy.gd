extends CharacterBody2D

@export var SPEED: float = 700.0

@onready var wall_detector := $wall_detector as RayCast2D
@onready var floor_detector := $floor_detector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction := -1


func _physics_process(delta:float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1
		
	if !floor_detector.is_colliding():
		direction *= -1
		floor_detector.scale.x *= -1
	
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false

	velocity.x = direction * SPEED * delta

	move_and_slide()


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurt":
		queue_free()
