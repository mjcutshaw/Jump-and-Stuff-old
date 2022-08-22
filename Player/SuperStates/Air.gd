extends MoveState
class_name AirState


var airTurn: bool = false

func enter() -> void:
	.enter()

	EventBus.emit_signal("playerGrounded", false)
	rotate_to_normal()


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, false)
	
	if player.test_move(player.global_transform, Vector2(player.velocity.x * delta, 0)):
		player.attempt_vertical_corner_correction(player.jumpCornerCorrectionVertical, delta)
	

func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_pressed("move_down"):
		player.set_collision_mask_bit(Globals.SEMISOLID, false)
	if Input.is_action_just_released("move_down"):
		player.semisolidResetTimer.start()
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


func air_velocity_logic(speed) -> void:
	#TODO: turn accel and friction into variables?
	if player.velocityPlayer.x != 0  and get_move_direction().x != 0 and (sign(player.velocityPlayer.x) != get_move_direction().x):
		airTurn = true
	
	if airTurn:
		player.velocityPlayer.x = move_toward(player.velocityPlayer.x, speed * get_move_direction().x, player.accelerationAir) 
	elif !airTurn:
		if get_move_direction().x != 0 and abs(player.velocityPlayer.x) < speed:
			apply_acceleration(player.accelerationAir)
		elif get_move_direction().x == 0:
			apply_friction(player.frictionAir)
		elif abs(player.velocityPlayer.x) >= speed:
			#TODO: look at not needing moveDirection
			momentum_logic(speed, true)
			
			#TODO: combime with below function


func neutral_air_momentum_logic() -> void:
	if !neutralMovement:
		velocity_logic(player.moveSpeed)
	if neutralMovement: ## Carry momentum with neutral moveDirection ##
		momentum_logic(player.moveSpeed, false)
	if get_move_direction() != Vector2.ZERO and neutralMovement: ## Cancel out neutral momentum
		neutralMovement = false


func terminal_velocity(speed)-> void:
	player.velocityPlayer.y = min(player.velocityPlayer.y, speed)
