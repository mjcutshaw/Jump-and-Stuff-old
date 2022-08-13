extends ParallaxLayer

export var speed: float = 15

func _physics_process(delta: float) -> void:
	motion_offset.x += speed * delta
