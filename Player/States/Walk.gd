extends GroundState

var skidding: bool = false
var skidTime: float
export (float, 1) var skidDuration: float = .3
export (float, 1) var skidPercent: float = .8
#TODO: skid state
#TODO: if nuetral entering use momentum
#LOOKAT: stick click for speed boost and shinespark

func enter() -> void:
	.enter()

	player.animPlayer.queue("Drive")
	skidTime = skidDuration
	#TODO: very speed of playback based on velocity
	#TODO: nuetral on entering
	#FIXME: don't keep dash velocity on ground
	


func exit() -> void:
	.exit()

	player.animPlayer.stop()


func physics(delta) -> void:
	.physics(delta)
	EventBus.emit_signal("debug1", "skid time: ", skidTime)
	EventBus.emit_signal("debug2", "skidding: ", skidding)

	if (sign(player.velocityPlayer.x) == player.moveDirection.x) and skidding:
		skidding = false
	if (player.moveDirection.x == 0 or skidding) and (player.ledgeLeft or player.ledgeRight):
		#FIXME: need to multiply times delta/ (1/FRAMERATE) and change to accel
		player.velocityPlayer.x = move_toward(player.velocityPlayer.x, 0, player.frictionSkid)
		## stop on ledge it no input. might be better to change friction
	if abs(player.velocityPlayer.x) > player.moveSpeed * skidPercent  and player.moveDirection.x != 0 and (sign(player.velocityPlayer.x) != player.moveDirection.x):
		skidding = true
		#Skid if over 8)% base speed
	
	if skidding:
		#FIXME: should not be the full amount
		if abs(player.moveDirection.x) > 0:
			##TODO: accel skid?
			#FIXME: need to multiply times delta/ (1/FRAMERATE)
			#old skid equation
#			player.velocityPlayer.x = move_toward(player.velocityPlayer.x, player.moveSpeed * player.moveDirection.x, player.accelerationGround)
			skidTime -= delta
			if skidTime < 0:
				skidding = false
				skidTime = skidDuration
				apply_acceleration(player.accelerationGround)
		elif player.moveDirection.x == 0:
			#FIXME: need to multiply times delta/ (1/FRAMERATE)
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
