extends AirState


func enter() -> void:
	.enter()

	if get_move_direction() == Vector2.ZERO:
		neutralMovement = true

func exit() -> void:
	.exit()

#	player.previousVelocity = player.velocity


func physics(delta) -> void:
	.physics(delta)

	neutral_air_momentum_logic()
	gravity_logic(player.gravityFall, delta)


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
