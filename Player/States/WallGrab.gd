extends WallState

func enter() -> void:
	.enter()

	#TODO: animation
	player.animPlayer.play("Base")


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	player.velocityPlayer.y = 0


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_released("grab"):
		return State.WallSlide

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.moveDirection.y != 0:
		return State.WallClimb

	return State.Null
