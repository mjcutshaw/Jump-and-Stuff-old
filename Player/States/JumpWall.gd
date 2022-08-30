extends JumpState


func enter() -> void:
	.enter()

	
	if player.moveDirection.x == player.lastWallDirection:
		player.velocityPlayer = Vector2(100 * -player.lastWallDirection, player.jumpVelocityMax)
		player.animPlayer.play("Dash Air Up")
	else:
		player.velocityPlayer.y = player.jumpVelocityMax
		player.velocityPlayer.x = player.moveSpeed * -player.lastWallDirection
		player.animPlayer.play("Jump Wall")


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

	if Input.is_action_just_released("jump"):
		return State.Fall

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.velocityPlayer.y > 0:
		return State.Fall

	return State.Null
