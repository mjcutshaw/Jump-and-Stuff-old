extends WallState


func enter() -> void:
	.enter()

	


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

#	gravity_logic(player.gravityFall/10, delta
#	cap_wall_slide_speed(player.wallSlideSpeed)
	
	if player.moveDirection.y == Globals.DOWN:
		player.velocityPlayer.y = player.wallQuickSlideSpeed
	else:
		player.velocityPlayer.y = player.wallSlideSpeed



func visual(delta) -> void:
	.visual(delta)

	player.characterRig.scale.x = -player.lastWallDirection


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	

	return State.Null
