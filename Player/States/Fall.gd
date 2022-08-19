extends AirState


func enter() -> void:
	.enter()

	EventBus.emit_signal("fall")
	if get_move_direction() == Vector2.ZERO:
		neutralMovement = true

func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	gravity_logic(player.gravityFall, delta)
	player.velocityPlayer.y = min(player.velocityPlayer.y, player.terminalVelocity)


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
