extends MoveState
class_name AirState

#TODO: air horizontal movement
func enter() -> void:
	.enter()

	


func exit() -> void:
	.exit()

#	player.previousVelocity = player.velocity


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, true)
	horizontal_velocity_logic()


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
		if get_move_direction() == Vector2.ZERO:
			return State.Idle
		else:
			return State.Walk

	return State.Null


func horizontal_velocity_logic():
	#TODO: feed variable for speed
	if get_move_direction().x != 0:
		#TODO: variable
		player.velocityPlayer.x = lerp(player.velocityPlayer.x, player.moveSpeed * get_move_strength().x, player.acceleration)
	elif get_move_direction().x == 0:
		player.velocityPlayer.x = lerp(player.velocityPlayer.x, player.moveSpeed * get_move_strength().x, player.friction)
	else:
		print("air horizontal velocity error")
