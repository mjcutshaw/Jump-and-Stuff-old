extends JumpState


func enter() -> void:
	.enter()

	player.animPlayer.play("Jump Double")
	EventBus.emit_signal("playerJumped")
	player.velocityPlayer.y = player.jumpVelocityMax
	player.consume_ability(PlayerAbilities.list.JumpAir, 1)
	neutral_move_direction_logic()


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	if neutralMovement:
		neutral_air_momentum_logic()
	if !neutralMovement:
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
