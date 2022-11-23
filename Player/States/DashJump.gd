extends JumpState

#TODO: will be a combo button
#TODO: should not trigger fall damage

func enter() -> void:
	.enter()

	EventBus.emit_signal("playerSuperJumped")
	player.velocityPlayer.x = 0
	player.velocityPlayer.y = player.jumpVelocityMax * player.dashJumpModifier
	player.animPlayer.play("Dash Up")
	player.set_collision_mask_bit(CollisionLayers.DashUp, false)


func exit() -> void:
	.exit()

	player.set_collision_mask_bit(CollisionLayers.DashUp, true)


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, true)
	air_velocity_logic(player.moveSpeed/player.dashJumpVelocityModifier)


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

	if player.velocityPlayer.y > - player.jumpHeightApex:
		return State.Apex

	return State.Null
