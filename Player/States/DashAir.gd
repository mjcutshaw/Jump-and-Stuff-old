extends DashState

#TODO: change to side dash
#TODO: add skill exits. keeping momenet with jump/glide at a certian time to keep momentum
#TODO: add right stick overwrite dash direction


var dashDirection

func enter() -> void:
	.enter()

	if sign(player.velocity.x) != 0:
		dashDirection = sign(player.velocity.x)
	else:
		dashDirection = player.facing
	
	player.velocityPlayer.y = 0
	player.velocityPrevious = player.velocityPlayer
	EventBus.emit_signal("playerDashed")
	rotate_to_normal()
	
	player.animPlayer.play("Dash Side")
	player.consume_ability(PlayerAbilities.list.DashAir, 1)
	player.set_collision_layer_bit(CollisionLayers.DashSide, true)
	player.set_collision_mask_bit(CollisionLayers.DashSide, false)


func exit() -> void:
	.exit()

	if player.moveDirection != Vector2.ZERO:
		player.velocityPlayer.x = player.velocityPrevious.x
	player.animPlayer.stop()
	dashDirection = 0
	player.set_collision_layer_bit(CollisionLayers.DashSide, false)
	player.set_collision_mask_bit(CollisionLayers.DashSide, true)


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, true)
	player.velocityPlayer.x = player.dashVelocity * dashDirection
	


func visual(delta) -> void:
	.visual(delta)

	player.characterRig.scale.x == dashDirection
	#Fixme: player can still face the wrong way after dash into jump(need better name)


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	#TODO: add dash up and down
	if Input.is_action_just_pressed("jump"):
		player.wall_jump_detection(100)
		#FICME: need to check against velocity direction
		#FOXME: if moveDirection is same as velocity return tall jump
		if player.jumpLeftCheck.is_colliding() or player.jumpRightCheck.is_colliding() and player.can_use_ability(PlayerAbilities.list.JumpWall):
			return State.JumpReverse
		elif player.can_use_ability(PlayerAbilities.list.JumpAir): #TODO: move to dash in air super state
			apply_acceleration(player.moveSpeed)
			return State.JumpAir
		else:
			return State.Fall

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.dashTimer.is_stopped():
		if player.is_on_floor():
			return State.Walk
		else:
			return State.Fall
	if player.coyoteWallTimer.is_stopped() and player.is_on_wall():
		return State.WallSlide

	return State.Null
