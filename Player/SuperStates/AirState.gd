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

	if Input.is_action_just_pressed("grab"):
		player.wallGrabCheckTimer.start()
	if Input.is_action_just_pressed("dash"):
		if !player.coyoteWallTimer.is_stopped():
			player.coyoteWallTimer.stop()
			return State.DashWall
		elif player.can_use_ability(Globals.abiliyList.Dash):
			return State.Dash
	if Input.is_action_pressed("move_down"): #fall through semisolids
		player.set_collision_mask_bit(CollisionLayers.SEMISOLID, false)
	if Input.is_action_just_released("move_down"):
		player.semisolidResetTimer.start()
	if Input.is_action_just_pressed("jump"):
		player.wall_jump_detection() #extended wall check
		if !player.coyoteWallTimer.is_stopped(): #fall off the wall, but can stil wall jump
			player.coyoteWallTimer.stop()
			return State.JumpWall
		elif !player.coyoteJumpTimer.is_stopped(): #leave ground, but stil can jump
			player.coyoteJumpTimer.stop()
			return State.Jump
		elif player.jumpGroundCheck.is_colliding(): #extened ground check, and air jump reset
			player.reset_ability(Globals.abiliyList.JumpAir)
			return State.Jump
#		elif player.jumpRightCheck.is_colliding() or player.jumpLeftCheck.is_colliding():
#			return State.JumpWall
			#FIXME: make extended wallcheck 
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
		neutralMovement = false
		EventBus.emit_signal("landed")
		return State.Walk
	if player.is_on_wall():
#	if player.is_on_wall() and player.velocityPlayer.y > 0: #FIXME: find a bettwer way to bring this back. wall jump in corners is difficult
		return State.WallSlide

	return State.Null


func air_velocity_logic(speed) -> void:
	#TODO: turn accel and friction into variables?
	if player.velocityPlayer.x != 0  and player.moveDirection.x != 0 and (sign(player.velocityPlayer.x) != player.moveDirection.x):
		airTurn = true
	#FIXME: air turn should stop other direction and timer till move other way
	if airTurn:
		player.velocityPlayer.x = move_toward(player.velocityPlayer.x, speed * player.moveDirection.x, player.accelerationAir) 
	elif !airTurn:
		if player.moveDirection.x != 0 and abs(player.velocityPlayer.x) < speed:
			apply_acceleration(player.accelerationAir)
		elif player.moveDirection.x == 0:
			apply_friction(player.frictionAir)
		elif abs(player.velocityPlayer.x) >= speed:
			#TODO: look at not needing moveDirection
			momentum_logic(speed, true)


func neutral_air_momentum_logic() -> void:
	momentum_logic(player.moveSpeed, false)
	if player.moveDirection.x != 0 and neutralMovement: ## Cancel out neutral momentum
		#TODO: variable to keep speed and timer 
		neutralMovement = false
