extends MoveState
class_name GroundState

func enter() -> void:
	.enter()

	player.velocityPlayer.y = 10
	EventBus.emit_signal("playerGrounded", true)
	player.set_collision_mask_bit(Globals.SEMISOLID, true)
	player.reset_ability(Globals.abiliyList.All)


func exit() -> void:
	.exit()

	player.coyoteJumpTimer.start()


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.SNAP_GROUND, true)


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

	if Input.is_action_just_pressed("jump"):
		if Input.is_action_pressed("move_down"):
			player.set_collision_mask_bit(Globals.SEMISOLID, false)
		else:
			return State.Jump
	if Input.is_action_just_pressed("dash"):
		return State.Dash
	if Input.is_action_just_pressed("super_jump"):
		return State.SuperJump

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if !player.bufferJumpTimer.is_stopped():
		player.bufferJumpTimer.stop()
		return State.Jump
	if !player.is_on_floor():
		player.coyoteJumpTimer.start()
		return State.Fall

	return State.Null



