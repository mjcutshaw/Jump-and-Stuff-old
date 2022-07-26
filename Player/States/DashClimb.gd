extends DashState

#TODO: do something if pushing off wall?

func enter() -> void:
	.enter()

	player.animPlayer.play("Dash Climb")
	player.velocityPlayer.y = -player.dashVelocity
	player.velocityPlayer.x = 0
	player.set_collision_layer_bit(CollisionLayers.DashUp, true)
	player.set_collision_mask_bit(CollisionLayers.DashUp, false)


func exit() -> void:
	.exit()

	
	player.set_collision_layer_bit(CollisionLayers.DashUp, false)
	player.set_collision_mask_bit(CollisionLayers.DashUp, true)


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.SNAP_Wall  * player.lastWallDirection, true)


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump") and player.is_on_wall():
		return State.JumpWall

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if !player.is_on_wall():
		player.velocityPlayer.y = player.velocityPlayer.y/2
		return State.Fall
	if player.is_on_ceiling():
		return State.WallSlide

	return State.Null
