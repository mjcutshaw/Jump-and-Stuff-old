extends DashState


func enter() -> void:
	.enter()

	
	EventBus.emit_signal("playerDashed")
	rotate_to_normal()
	player.dashTimer.start()
	player.velocityPlayer.y = -player.dashVelocity/2
	player.consume_ability(PlayerAbilities.list.DashUp, 1)
	player.animPlayer.play("Dash Up")
	player.set_collision_mask_bit(CollisionLayers.DashUp, true)


func exit() -> void:
	.exit()

	player.animPlayer.stop()
	player.set_collision_mask_bit(CollisionLayers.DashUp, false)


func physics(delta) -> void:
	.physics(delta)

	player.velocityPlayer.x = 0
	player.move_logic(player.NO_SNAP, true)


func visual(delta) -> void:
	.visual(delta)

	#TODO: if jump pressed and is near wall kick off for a boost


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
		if player.can_use_ability(PlayerAbilities.list.JumpAir):
			return State.JumpAir
		else:
			return State.Fall

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.dashTimer.is_stopped():
		if player.is_on_floor():
			return State.Walk
		else:
			return State.Fall

	return State.Null
