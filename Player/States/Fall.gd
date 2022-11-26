extends AirState

#TODO: fall damage, time or speed based

func enter() -> void:
	.enter()

	player.fallDamage = false
	player.fallTimer.start()
	EventBus.emit_signal("fall")
	player.animPlayer.play("Fall")
	neutral_move_direction_logic()


func exit() -> void:
	.exit()

	if player.fallTimer.is_stopped():
		player.fallDamage = true
		player.fallTimer.stop()


func physics(delta) -> void:
	.physics(delta)

	gravity_logic(player.gravityFall, delta)
	if player.moveDirection != Vector2.DOWN:
		terminal_velocity(player.terminalVelocity) #Fall faster when pressing down, might need to cap it
	
	if neutralMovement and abs(player.velocityPlayer.x) > player.moveSpeed:
		neutral_air_momentum_logic()
	if !neutralMovement:
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

	if player.glidePressed  and player.can_use_ability(PlayerAbilities.list.Glide):
		return State.Glide
	if player.inWater:
		return State.Swim

	return State.Null
