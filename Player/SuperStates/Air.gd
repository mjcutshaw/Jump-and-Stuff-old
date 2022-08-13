extends MoveState
class_name AirState

#TODO: corner correction

func enter() -> void:
	.enter()

	EventBus.emit_signal("playerGrounded", false)


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, false)


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

	if player.is_on_floor():
		player.animPlayer.play("Landing")
		EventBus.emit_signal("landed")
		if get_move_direction() == Vector2.ZERO:
			return State.Idle
		else:
			return State.Walk

	return State.Null



func neutral_air_momentum_logic():
	if !neutralMovement:
		velocity_logic(player.moveSpeed)
	if neutralMovement: ## Carry momentum with neutral moveDirection ##
		momentum_logic(player.moveSpeed, false)
	if get_move_direction() != Vector2.ZERO and neutralMovement: ## Cancel out neutral momentum
		neutralMovement = false
