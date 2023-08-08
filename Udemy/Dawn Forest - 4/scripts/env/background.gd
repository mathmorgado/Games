extends ParallaxBackground
class_name Background

@export var can_process: bool
@export var layer_speed: Array

func _ready():
	if !can_process:
		set_physics_process(false)


func _physics_process(delta):
	for layer in get_child_count():
		if get_child(layer) is ParallaxLayer:
			get_child(layer).motion_offset.x -= delta * layer_speed[layer]
