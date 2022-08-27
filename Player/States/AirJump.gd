extends JumpState


func enter() -> void:
	.enter()

	EventBus.emit_signal("playerJumped")
	player.velocityPlayer.y = player.jumpVelocityMax
	player.consume_ability(Globals.abiliyList.JumpAir, 1)


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	


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

	

	return State.Null
