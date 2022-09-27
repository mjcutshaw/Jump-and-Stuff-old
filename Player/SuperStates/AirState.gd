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

	player.turn_sprite()


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("dash") and player.can_use_ability(Globals.abiliyList.Dash):
		return State.Dash
	if Input.is_action_pressed("move_down"):
		player.set_collision_mask_bit(CollisionLayers.SEMISOLID, false)
		#TODO: figure a better way to do this
	if Input.is_action_just_released("move_down"):
		player.semisolidResetTimer.start()
	if Input.is_action_just_pressed("jump"):
		if !player.coyoteJumpWallTimer.is_stopped():
			player.coyoteJumpWallTimer.stop()
			return State.JumpWall
		elif !player.coyoteJumpTimer.is_stopped(): 
			player.coyoteJumpTimer.stop()
			return State.Jump
		#TODO: extend wall and ground raycast to see if you are close and us that instead
		elif player.can_use_ability(Globals.abiliyList.JumpAir):
			return State.JumpAir
		else:
			player.bufferJumpTimer.start()
	if Input.is_action_just_pressed("ground_pound"):
		return	 State.GroundPound
	if Input.is_action_just_pressed("hookshot") and player.targetHookShot != null:
		return State.HookShot

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.is_on_floor():
		player.animPlayer.play("Landing")
		EventBus.emit_signal("landed")
		return State.Walk
	if player.is_on_wall() and player.velocityPlayer.y > 0:
		return State.WallSlide

	return State.Null


func air_velocity_logic(speed) -> void:
	#TODO: turn accel and friction into variables?
	if player.velocityPlayer.x != 0  and player.moveDirection.x != 0 and (sign(player.velocityPlayer.x) != player.moveDirection.x):
		airTurn = true
	
	if airTurn:
		#FIXME: need to multiply times delta/ (1/FRAMERATE)
		player.velocityPlayer.x = move_toward(player.velocityPlayer.x, speed * player.moveDirection.x, player.accelerationAir) 
	elif !airTurn:
		if player.moveDirection.x != 0 and abs(player.velocityPlayer.x) < speed:
			apply_acceleration(player.accelerationAir)
		elif player.moveDirection.x == 0:
			apply_friction(player.frictionAir)
		elif abs(player.velocityPlayer.x) >= speed:
			#TODO: look at not needing moveDirection
			momentum_logic(speed, true)
			
			#TODO: combime with below function


func neutral_air_momentum_logic() -> void:
	momentum_logic(player.moveSpeed, false)
	if player.moveDirection.x != 0 and neutralMovement: ## Cancel out neutral momentum
		#TODO: variable to keep speed and timer 
		neutralMovement = false
