extends MoveState
class_name GroundState

func enter() -> void:
	.enter()

	player.velocityPlayer.y = 10
	EventBus.emit_signal("playerGrounded", true)


func exit() -> void:
	.exit()

	player.coyoteJumpTimer.start()
	
	#TODO: need to move to other stats, since this get exited between idle and walk
#	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
#	tween.tween_property(player, "rotation", 0*PI, .2)


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.SNAP_GROUND, true)


func visual(delta) -> void:
	.visual(delta)

	# player align to floor
	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property(player, "rotation", player.get_floor_normal().angle() + PI/2, .5)
	#TODO: find a way to not run every frame


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
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
		return State.Fall

	return State.Null



