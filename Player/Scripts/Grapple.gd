extends Line2D

onready var aim: Area2D = $Aim

#FIXME: grabbing offset global position
#TODO: change to hookshot

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("grapple"):
		if aim.targetGrapple != null:
			EventBus.emit_signal("debug1", "target", aim.targetGrapple)
			
			add_point(global_position)
			add_point(aim.targetGrapple.global_position, 1)
			remove_point(0)
#	if Input.is_action_just_released("grapple"):
#		clear_points()
