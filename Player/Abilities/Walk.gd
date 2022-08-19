extends GroundAbilities
#TODO: eventually break out to left and right



func enter() -> void:
	.enter()

	


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		pass



func state_check(delta: float) -> void:
	pass
