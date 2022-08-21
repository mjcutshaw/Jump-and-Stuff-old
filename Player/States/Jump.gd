extends JumpState

#TODO: dash jump
func enter() -> void:
	.enter()

	player.velocityPlayer.y = player.jumpVelocityMax


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	air_velocity_logic(player.moveSpeed)


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	

	return State.Null
