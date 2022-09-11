extends GroundState

export (float, 1) var skidDuration: float = 0.15
export (float, 1) var skidPercent: float = 0.8

var skidTime: float


func enter() -> void:
	.enter()

	#TODO: create skid animation
	player.animPlayer.queue("Drive")
	skidTime = skidDuration


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)
	EventBus.emit_signal("debug1", "skid time: ", skidTime)

	skidTime -= delta
	if player.moveDirection.x == 0 :
		player.velocityPlayer.x = move_toward(player.velocityPlayer.x, 0, player.frictionSkid)


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

	if skidTime < 0:
		apply_acceleration(player.accelerationGround)
		return State.Walk
	if player.velocityPlayer.x == 0:
		return State.Idle

	return State.Null
