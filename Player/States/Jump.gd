extends JumpState


func enter() -> void:
	.enter()

	#TODO: coyote time and buffer jump
	EventBus.emit_signal("jumped")
	player.velocityPlayer.y = player.jumpVelocityMax
	player.animPlayer.play("jump")


func exit() -> void:
	.exit()

#	player.previousVelocity = player.velocity


func physics(delta) -> void:
	.physics(delta)

	momentum_logic(player.moveSpeed, true)


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
