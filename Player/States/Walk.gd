extends GroundState


var pTime
var pTimeAmount: int = 1

func enter() -> void:
	.enter()

	pTime = pTimeAmount


func exit() -> void:
	.exit()

#	player.previousVelocity = player.velocity


func physics(delta) -> void:
	.physics(delta)

	print(pTime)
	pTime = clamp(pTime, 0 , pTimeAmount)
	
	if pTime == 0 and (player.velocityPlayer.x >= Stats.moveSpeed):
		player.velocityPlayer.x = Stats.moveSpeed * 1.2
	if Stats.moveSpeed > abs(player.velocityPlayer.x):
		## acceleration ##
		player.velocityPlayer.x = get_move_strength().x * round(lerp(abs(player.velocityPlayer.x), Stats.moveSpeed, Stats.acceleration)) 
		if abs(player.velocityPlayer.x) == (Stats.moveSpeed - 1):
			player.velocityPlayer.x = Stats.moveSpeed * get_move_direction().x
		pTime += delta
	elif Stats.moveSpeed < abs(player.velocityPlayer.x):
		## maintain momentum ##
		player.velocityPlayer.x = get_move_strength().x * abs(player.velocityPlayer.x)
	elif Stats.moveSpeed == abs(player.velocityPlayer.x):
		## maintain speed
		player.velocityPlayer.x = get_move_strength().x * Stats.moveSpeed
		pTime -= delta
	else:
		print("velocity logic error")


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
