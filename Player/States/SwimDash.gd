extends SwimState


func enter() -> void:
	.enter()

	player.animPlayer.play("Dash Side")
	player.velocityPlayer = player.moveDirection * player.dashVelocity
	player.dashTimer.start()
	player.set_collision_mask_bit(CollisionLayers.SwimDash, true)


func exit() -> void:
	.exit()

	player.set_collision_mask_bit(CollisionLayers.SwimDash, false)


func physics(delta) -> void:
	.physics(delta)

	


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

	if !player.inWater:
		player.velocityPlayer.y = player.velocityPlayer.y/2
		return State.Fall
	if player.dashTimer.is_stopped():
		return State.Swim

	return State.Null
