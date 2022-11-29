extends DashState

#TODO:  make like hollow knight
func enter() -> void:
	.enter()

	
	player.velocityPlayer.x = -player.lastWallDirection * player.dashVelocity * 1.5
	#TODO: new animation
	player.animPlayer.play("Dash Side")
	player.set_collision_layer_bit(CollisionLayers.DashSide, true)
	player.set_collision_mask_bit(CollisionLayers.DashSide, false)


func exit() -> void:
	.exit()

	player.set_collision_layer_bit(CollisionLayers.DashSide, true)
	player.set_collision_mask_bit(CollisionLayers.DashSide, false)


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, true)
	player.velocityPlayer.y = 0


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
		if player.can_use_ability(PlayerAbilities.list.JumpAir):
			return State.JumpAir
		else:
			return State.Fall
	elif Input.is_action_just_pressed("glide") and player.can_use_ability(PlayerAbilities.list.Glide):
		return State.Glide

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.is_on_wall() and player.coyoteWallTimer.is_stopped():
		return State.Bonk

	return State.Null
