 extends MoveState

#TODO: stun state after round pound
#TODO: change to dash down

func enter() -> void:
	.enter()

	player.animPlayer.play("Dash Down")
	player.set_collision_mask_bit(CollisionLayers.DashDown, false)


func exit() -> void:
	.exit()

	player.animPlayer.stop()
	player.set_collision_mask_bit(CollisionLayers.DashDown, true)


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, false)
	player.velocityPlayer.x = 0
	player.velocityPlayer.y = player.dashVelocity


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("dash") and player.can_use_ability(Globals.abiliyList.DashGround):
		return State.DashGround
	if Input.is_action_just_released("jump"):
		if player.can_use_ability(Globals.abiliyList.JumpAir):
			return State.JumpAir
		else:
			return State.Fall

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.is_on_floor():
		return State.Idle

	return State.Null
