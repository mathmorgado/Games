extends ParallaxBackground
class_name Background

export(bool) var can_process
export(Array, int) var layer_speed

func _ready():
	if !can_process:
		set_physics_process(false)


func _physics_process(delta):
	for layer in get_child_count():
		if get_child(layer) is ParallaxLayer: # Evita de mexer a Mask
			get_child(layer).motion_offset.x -= delta * layer_speed[layer]
