extends MoveState

#TODO: own gravity
#TODO: no gravity till player pass point

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
	#TODO: figure out 
	var destination: Vector2 = player.targetHookShot.global_position
	var disp := destination - player.global_position

	# The height from the higher of the two points to the highest point in the
	# arc.
	var h := Globals.TILE_SIZE

	# The total height from the lower of the two points to the highest point in
	# the arc.
	var H := abs(disp.y) + h

	var g := player.gravityFall

	var player_below_dest := disp.y < 0

	var time_up := sqrt(2 * (H if player_below_dest else h) / g)
	var time_down := sqrt(2 * (h if player_below_dest else H) / g)

	var velocity := Vector2.ZERO
	velocity.x = disp.x / float(time_up + time_down)
	velocity.y = -sqrt(2 * (H if player_below_dest else h) * g)
	return velocity
