extends GroundState

var skidding: bool = false
#TODO: if nuetral entering use momentum

func enter() -> void:
	.enter()

	#TODO: animation state machine
	player.animPlayer.queue("Drive")
	#TODO: very speed of playback based on velocity
	#TODO: nuetral on entering
	


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	if (sign(player.velocityPlayer.x) == player.moveDirection.x) and skidding:
		skidding = false
	if (player.moveDirection.x == 0 or skidding) and (player.ledgeLeft or player.ledgeRight):
		player.velocityPlayer.x = move_toward(player.velocityPlayer.x, 0, player.frictionSkid)
		## stop on ledge it no input. might be better to change friction
	if abs(player.velocityPlayer.x) > player.moveSpeed  and player.moveDirection.x != 0 and (sign(player.velocityPlayer.x) != player.moveDirection.x):
		skidding = true
		#Skid if over base speed
	
	if skidding:
		if abs(player.moveDirection.x) > 0:
			##TODO: accel skid?
			player.velocityPlayer.x = move_toward(player.velocityPlayer.x, player.moveSpeed * player.moveDirection.x, player.accelerationGround)
		elif player.moveDirection.x == 0:
			player.velocityPlayer.x = move_toward(player.velocityPlayer.x, 0, player.frictionSkid)
	elif !skidding:
		if player.moveDirection.x != 0 and player.velocityPlayer.x < player.moveSpeed:
			apply_acceleration(player.accelerationGround)
		elif player.moveDirection.x == 0:
			apply_friction(player.frictionGround)
		elif player.velocityPlayer.x >= player.moveSpeed:
			#TODO: look at not needing moveDirection
			momentum_logic(player.moveSpeed, true)
	if player.is_on_wall():
		player.velocityPlayer.x = 0


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
