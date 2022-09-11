extends GroundState

var skidding: bool = false
export (float, 1) var skidPercent: float = .8
export  var slowDownTime: float = 10
#TODO: if nuetral entering use momentum
#LOOKAT: stick click for speed boost and shinespark

func enter() -> void:
	.enter()

	player.animPlayer.queue("Drive")
	#TODO: very speed of playback based on velocity
	#TODO: nuetral on entering
	#FIXME: don't keep dash velocity on ground
	


func exit() -> void:
	.exit()

	player.animPlayer.stop()
	skidding = false


func physics(delta) -> void:
	.physics(delta)

	if abs(player.velocityPlayer.x) > player.moveSpeed:
		player.velocityPlayer.x = move_toward(abs(player.velocityPlayer.x), player.moveSpeed, slowDownTime) * sign(player.velocityPlayer.x)
		#Slow player down, meeds a timer.
	if abs(player.velocityPlayer.x) > player.moveSpeed * skidPercent  and player.moveDirection.x != 0 and (sign(player.velocityPlayer.x) != player.moveDirection.x):
		skidding = true
		#Skid if over percent of base speed
		#FIXME: get this to work in state check
	elif player.moveDirection.x != 0 and player.velocityPlayer.x < player.moveSpeed:
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
	if skidding:
		return State.Skid

	return State.Null
