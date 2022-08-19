extends GroundState

var skidding: bool = false
func enter() -> void:
	.enter()

	player.animPlayer.queue("Drive")
	#TODO: very speed of playback based on velocity


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	if abs(player.velocityPlayer.x)  >= 16 and skidding:
		skidding = false
	if get_move_direction().x == 0 and (player.ledgeLeft or player.ledgeRight):
		player.velocityPlayer.x = 0 ## stop on ledge it no input. might be better to change friction
		#WATCH: might want to change this to faster friction
	if player.velocityPlayer.x != 0  and get_move_direction().x != 0 and (sign(player.velocityPlayer.x) != get_move_direction().x):
		skidding = true
		
	
	if skidding:
		var oldVelocity = player.velocityPlayer.x
		player.velocityPlayer.x = move_toward(player.velocityPlayer.x, player.moveSpeed * get_move_direction().x, player.acceleration) 
	elif !skidding:
		if get_move_direction().x != 0 and player.velocityPlayer.x < player.moveSpeed:
			apply_acceleration()
		elif get_move_direction().x == 0:
			apply_friction()
		elif player.velocityPlayer.x >= player.moveSpeed:
			#TODO: look at not needing moveDirection
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
