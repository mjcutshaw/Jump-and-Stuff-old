extends JumpState

func enter() -> void:
	.enter()

	EventBus.emit_signal("playerJumped")
	player.velocityPlayer.y = player.jumpVelocityMax
	player.animPlayer.play("Jump")
	
	neutral_move_direction_logic()
	
	if player.previousState.name == "Walk":
		neutralMovement = false

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

	## variable jump height ##
	if Input.is_action_just_released("jump"):
		player.velocityPlayer.y = max(player.velocityPlayer.y, player.jumpHeightMin)
		return State.Apex

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.velocityPlayer.y > - player.jumpHeightApex:
		return State.Apex

	return State.Null
