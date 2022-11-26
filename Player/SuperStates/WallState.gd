extends MoveState
class_name WallState


func enter() -> void:
	.enter()

	player.velocityPrevious = player.velocityPlayer
	if player.unlockedJumpWall:
		player.reset_ability(PlayerAbilities.list.JumpAir)
	if player.unlockedDashAir:
		player.reset_ability(PlayerAbilities.list.DashAir)


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.SNAP_Wall * player.wall_detection(), false)


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump") and player.can_use_ability(PlayerAbilities.list.JumpWall):
		return State.JumpWall
	
	#LOOKAT: make these a charge like hollow?
	if Input.is_action_just_pressed("dash_wall"):
		return State.DashWall
	if Input.is_action_just_pressed("dash_climb"):
		return State.DashClimb

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if !player.wallGrabCheckTimer.is_stopped():
		player.wallGrabCheckTimer.stop()
		return State.WallGrab
	if abs(player.velocityPrevious.x) > (player.moveSpeed * 1.5):
		return State.Bonk
	if player.is_on_floor():
		return State.Walk
	if player.inWater and player.velocityPlayer.y > 0:
		return State.Swim
	if  player.moveDirection.x == Globals.LEFT and player.lastWallDirection == Globals.RIGHT:
		player.velocityPlayer = Vector2(-20,-10)
		player.coyoteWallTimer.start()
		return State.Fall
	if player.moveDirection.x == Globals.RIGHT and player.lastWallDirection == Globals.LEFT:
		player.velocityPlayer = Vector2(20, -10)
		player.coyoteWallTimer.start()
		return State.Fall
	
	if !player.is_on_wall():
		player.coyoteWallTimer.start()
		return State.Fall

	return State.Null


func cap_wall_slide_speed(amount):
	player.velocityPlayer.y = max(player.velocityPlayer.y, amount)
