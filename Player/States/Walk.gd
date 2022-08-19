extends GroundState


func enter() -> void:
	.enter()

	player.animPlayer.queue("Drive")
	#TODO: very speed of playback based on velocity


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	if get_move_direction().x == 0 and (player.ledgeLeft or player.ledgeRight):
		player.velocityPlayer.x = 0 ## stop on ledge it no input. might be better to change friction
		#WATCH: might want to change this to faster friction
	if get_move_direction().x != 0 and player.velocityPlayer.x < player.moveSpeed:
		apply_acceleration()
	elif get_move_direction().x == 0:
		apply_friction()
	elif player.velocityPlayer.x >= player.moveSpeed:
		momentum_logic(player.moveSpeed, true)


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

	if player.velocityPlayer.x == 0:
		return State.Idle

	return State.Null
