extends Line2D
#TODO: make generic to work between abilities
#TODO: also need a line for indicating angle that character will take, guacamelee
onready var aim: Area2D = $Aim

#FIXME: grabbing offset global position

func _ready() -> void:
	#TODO: connect signal of player reaching to clear points
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("grapple"):
		clear_grapple() #TODO: remove later
		if aim.target != null:
#			EventBus.emit_signal("debug1", aim.targetGrapple.global_position)
			EventBus.emit_signal("hookshotTarget", aim.targetGrapple.global_position)
			global_position = owner.global_position
			add_point(global_position)
			add_point(aim.targetGrapple.global_position, 1)
#			remove_point(0)
#	if Input.is_action_just_released("grapple"):
#		clear_points()

func clear_grapple():
	clear_points()
