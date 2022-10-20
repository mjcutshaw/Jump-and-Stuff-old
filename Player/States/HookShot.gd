extends MoveState

#TODO: no gravity till player pass point
#TODO: area2d that stops player
#TODO: figrue out how to launch player past

const slowRadius: = 100.0

func enter() -> void:
	.enter()

	player.velocityPlayer = hookshot_velocity()


func exit() -> void:
	.exit()

	player.targetHookShot = null


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, false)
	gravity_logic(player.gravityFall, delta)


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

	if player.velocityPlayer.y > 0:
		return State.Fall
	if player.is_on_wall():
		return State.WallSlide
	if player.is_on_floor():
		return State.Walk

	return State.Null

func hookshot_velocity() -> Vector2:
	var playerPosition: Vector2 = player.global_position
	var destination: Vector2 = player.targetHookShot.global_position
	
	var distanceToTarget: float = playerPosition.distance_to(destination)
	var desiredVelocity: Vector2 = playerPosition.direction_to(destination) * player.dashVelocity 
	
	if distanceToTarget < slowRadius:
		desiredVelocity *= (distanceToTarget / slowRadius) * .75 + .25
	
	return desiredVelocity
