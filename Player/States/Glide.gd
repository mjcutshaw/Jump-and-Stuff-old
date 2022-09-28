extends AirState

#TODO: find a way to go through semisolids

func enter() -> void:
	.enter()

	EventBus.emit_signal("playerGlide")
	player.animPlayer.play("Glide")
	if player.inWind:
		player.reset_ability(Globals.abiliyList.All)
	neutral_move_direction_logic()


func exit() -> void:
	.exit()

	#TODO: close animation


func physics(delta) -> void:
	.physics(delta)

	if player.inWind:
		player.velocityPlayer.y = -50
		#TODO: get strength from wind
	else:
		gravity_logic(player.gravityGlide, delta)
		terminal_velocity(player.terminalVelocity/player.glideFallSpeedModifier)
	
	if neutralMovement:
		neutral_air_momentum_logic()
	if !neutralMovement:
		air_velocity_logic(player.moveSpeed/player.glideSpeedModifier)


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_released("glide"):
		return State.Fall
		#TODO: settings for toggle glide

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.is_on_floor():
		return State.Walk

	return State.Null
