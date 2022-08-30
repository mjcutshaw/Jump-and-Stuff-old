extends MoveState
class_name WallState


func enter() -> void:
	.enter()

	


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

	

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.is_on_floor():
		return State.Walk
	
	if  player.moveDirection.x == Globals.LEFT and player.lastWallDirection == Globals.RIGHT:
		player.velocityPlayer = Vector2(-20,-10)
		player.coyoteJumpWallTimer.start()
		return State.Fall
	if player.moveDirection.x == Globals.RIGHT and player.lastWallDirection == Globals.LEFT:
		player.velocityPlayer = Vector2(20, -10)
		player.coyoteJumpWallTimer.start()
		return State.Fall
	
	if !player.is_on_wall():
		player.coyoteJumpWallTimer.start()
		return State.Fall

	return State.Null


func cap_wall_slide_speed(amount):
	player.velocityPlayer.y = max(player.velocity.y, amount)
