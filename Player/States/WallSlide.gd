extends WallState


func enter() -> void:
	.enter()

	player.animPlayer.play("Wall Slide")


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

#	gravity_logic(player.gravityFall/10, delta
#	cap_wall_slide_speed(player.wallSlideSpeed)
	
	#TODO: adjust speeds and use accel and friction
	if player.moveDirection.y == Globals.DOWN:
		gravity_logic(player.gravityFall/10, delta)
	else:
		player.velocityPlayer.y = player.wallSlideSpeed



func visual(delta) -> void:
	.visual(delta)

	if player.lastWallDirection != 0:
		player.characterRig.scale.x = -player.lastWallDirection


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("grab") or Input.is_action_pressed("grab"):
		return State.WallGrab

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	

	return State.Null
