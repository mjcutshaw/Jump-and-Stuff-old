extends MoveState
class_name AirState

#TODO: corner correction

var airTurn: bool = false

func enter() -> void:
	.enter()

	EventBus.emit_signal("playerGrounded", false)


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, false)
	
	if player.velocityPlayer.x != 0  and get_move_direction().x != 0 and (sign(player.velocityPlayer.x) != get_move_direction().x):
		airTurn = true
	
	if airTurn:
		player.velocityPlayer.x = move_toward(player.velocityPlayer.x, player.moveSpeed * get_move_direction().x, player.accelerationAir) 
	elif !airTurn:
		if get_move_direction().x != 0 and player.velocityPlayer.x < player.moveSpeed:
			apply_acceleration(player.accelerationAir)
		elif get_move_direction().x == 0:
			apply_friction(player.frictionAir)
		elif player.velocityPlayer.x >= player.moveSpeed:
			#TODO: look at not needing moveDirection
			momentum_logic(player.moveSpeed, true)
	
	if player.test_move(player.global_transform, Vector2(player.velocity.x * delta, 0)):
		player.attempt_vertical_corner_correction(player.jumpCornerCorrectionVertical, delta)
	

func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
#		if !player.coyoteJumpWallTimer.is_stopped():
#			player.coyoteJumpWallTimer.stop()
#			return State.JumpWall
		if !player.coyoteJumpTimer.is_stopped(): 
			player.coyoteJumpTimer.stop()
			return State.Jump
		else:
			player.bufferJumpTimer.start()

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.is_on_floor():
		player.animPlayer.play("Landing")
		EventBus.emit_signal("landed")
		return State.Walk

	return State.Null



func neutral_air_momentum_logic():
	if !neutralMovement:
		velocity_logic(player.moveSpeed)
	if neutralMovement: ## Carry momentum with neutral moveDirection ##
		momentum_logic(player.moveSpeed, false)
	if get_move_direction() != Vector2.ZERO and neutralMovement: ## Cancel out neutral momentum
		neutralMovement = false
