extends MoveState
class_name GroundState

func enter() -> void:
	.enter()

	player.velocityPlayer.y = 10
	EventBus.emit_signal("playerGrounded", true)


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.SNAP_GROUND, true)


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
		return State.Jump

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if !player.is_on_floor():
		return State.Fall

	return State.Null


func apply_acceleration() -> void:
	player.velocityPlayer.x = move_toward(abs(player.velocityPlayer.x), player.moveSpeed, player.acceleration) * get_move_direction().x

func apply_friction() -> void:
	player.velocityPlayer.x = move_toward(player.velocityPlayer.x, 0, player.friction)
