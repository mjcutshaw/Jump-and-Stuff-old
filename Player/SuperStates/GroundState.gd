extends MoveState
class_name GroundState

func enter() -> void:
	.enter()

	player.velocityPlayer.y = 10
	EventBus.emit_signal("playerGrounded", true)
	player.set_collision_mask_bit(CollisionLayers.SEMISOLID, true)
	player.reset_ability(PlayerAbilities.list.All) #FIXME: change to signals


func exit() -> void:
	.exit()

	player.coyoteJumpTimer.start()


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.SNAP_GROUND, true)
	if player.moveDirection.x == 0 and (player.ledgeLeft or player.ledgeRight):
		player.velocityPlayer.x = move_toward(player.velocityPlayer.x, 0, player.frictionSkid)
		## stop on ledge it no input. might be better to change friction


func visual(delta) -> void:
	.visual(delta)

	# player align to floor
	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property(player, "rotation", player.get_floor_normal().angle() + PI/2, .5)
	#TODO: find a way to not run every frame
	player.turn_sprite()


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump") and !Input.is_action_pressed("dash"):
		if Input.is_action_pressed("move_down"):
			player.set_collision_mask_bit(CollisionLayers.SEMISOLID, false)
		else:
			return State.Jump
	if Input.is_action_just_pressed("dash"): 
		dash_pressed_buffer()
	if Input.is_action_just_pressed("hookshot") and player.targetHookShot != null:
		return State.HookShot
	
	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState


	if dashBufferState != BaseState.State.Null:
		if player.can_use_ability(PlayerAbilities.list.DashJump) and dashBufferState == BaseState.State.DashJump:
			return BaseState.State.DashJump
		if player.can_use_ability(PlayerAbilities.list.DashGround) and dashBufferState == BaseState.State.DashGround:
			return BaseState.State.DashGround
		if player.can_use_ability(PlayerAbilities.list.DashUp) and dashBufferState == BaseState.State.DashUp:
			return BaseState.State.DashUp
		if player.can_use_ability(PlayerAbilities.list.DashDown) and dashBufferState == BaseState.State.DashDown:
			return BaseState.State.DashDown
	if !player.bufferJumpTimer.is_stopped():
		player.bufferJumpTimer.stop()
		return State.Jump
	if !player.is_on_floor():
		player.coyoteJumpTimer.start()
		return State.Fall
	if player.inWater:
		return State.Swim
	if player.fallDamage:
		return State.FallDamage

	return State.Null



