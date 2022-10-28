extends JumpState

var jumpDirection: int

func enter() -> void:
	.enter()
	#FIXME this breaks wall jumps
	if player.jumpLeftCheck.is_colliding():
		jumpDirection = Globals.RIGHT
		
	elif player.jumpRightCheck.is_colliding():
		jumpDirection = Globals.LEFT
	
	player.characterRig.scale.x = jumpDirection
	player.velocityPlayer.y = player.jumpVelocityMax
	if abs(player.velocityPlayer.x) > player.moveSpeed:
		player.velocityPlayer.x = abs(player.velocity.x) * jumpDirection
	else:
		player.velocityPlayer.x = player.moveSpeed * jumpDirection

	neutral_move_direction_logic()


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	if neutralMovement:
		neutral_air_momentum_logic()
	if !neutralMovement:
		air_velocity_logic(player.moveSpeed)


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_released("jump"):
		return State.Fall

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.velocityPlayer.y > 0:
		return State.Fall

	return State.Null
