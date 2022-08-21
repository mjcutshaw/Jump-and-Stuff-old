extends JumpState

#TODO: will be a combo button

func enter() -> void:
	.enter()

	EventBus.emit_signal("playerSuperJumped")
	player.velocityPlayer.y = player.jumpVelocityMax*2 
	#TODO: own variable


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	air_velocity_logic(player.moveSpeed/5)


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	## variable jump height ##
	if Input.is_action_just_released("jump"):
		player.velocityPlayer.y = max(player.velocityPlayer.y, player.jumpHeightMin*3)
		return State.Fall

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	

	return State.Null
