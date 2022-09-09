extends AirState


func enter() -> void:
	.enter()

	EventBus.emit_signal("fall")
	if player.moveDirection == Vector2.ZERO:
		neutralMovement = true
	player.animPlayer.play("Fall")


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	gravity_logic(player.gravityFall, delta)
	terminal_velocity(player.terminalVelocity)
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

	if player.glidePressed:
		return State.Glide
	if player.inWater == true:
		return State.Swim

	return State.Null
