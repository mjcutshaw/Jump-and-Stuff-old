extends GroundState




func enter() -> void:
	.enter()

	player.animPlayer.queue("Drive")
	#TODO: very speed of playback based on velocity


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	if get_move_strength().x != 0:
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

	if get_move_direction().x == 0:
		return State.Idle

	return State.Null
