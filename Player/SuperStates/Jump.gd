extends AirState
class_name JumpState


func enter() -> void:
	.enter()

	EventBus.emit_signal("playerJumped")
	player.coyoteJumpTimer.stop()


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	gravity_logic(player.gravityJump, delta)
	
	if player.test_move(player.global_transform, Vector2(0, player.velocity.y * delta)):
		player.attempt_horizontal_corner_correction(player.jumpCornerCorrectionHorizontal, delta)


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	## variable jump height ##
	if Input.is_action_just_released("jump"):
		player.velocityPlayer.y = max(player.velocityPlayer.y, player.jumpHeightMin)
		return State.Fall

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.is_on_ceiling():
		return State.Fall
	if player.velocityPlayer.y > - player.jumpHeightApex:
		return State.Apex

	return State.Null
