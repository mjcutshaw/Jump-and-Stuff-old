extends GroundState


func enter() -> void:
	.enter()

	


func exit() -> void:
	.exit()

#	player.previousVelocity = player.velocity


func physics(delta) -> void:
	.physics(delta)

	player.velocityPlayer.x = lerp(player.velocityPlayer.x, 0, player.friction)
	if player.velocityPlayer.x < 5:
		player.velocityPlayer.x = 0


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

	if get_move_direction().x != 0:
		return State.Walk

	return State.Null
