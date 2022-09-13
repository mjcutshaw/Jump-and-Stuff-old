extends SwimState

#TODO: turn into super swim state
#TODO: water dash

var isSurfacing: bool = false

func enter() -> void:
	.enter()

	player.animPlayer.play("Swim")


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	
	
	if player.moveDirection != Globals.ZERO:
		swim_velocity_logic(player.moveSpeed/player.swimSpeedModifier)
	else:
		player.velocityPlayer.y = -64
		apply_friction(player.frictionGround)
	
	if player.velocityPlayer.y < 0 and !player.swimLevel.is_colliding():
		player.velocityPlayer.y = 0
		isSurfacing = true
	else:
		isSurfacing = false

func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if isSurfacing and Input.is_action_just_pressed("jump"):
		return State.Jump
	#FIXME: needs more range closer to the surface
	if Input.is_action_just_pressed("dash"):
		return State.SwimDash

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if !player.inWater:
		return State.Fall

	return State.Null




#func apply_swim_acceleration(amount) -> void:
#TODO: need to multiply times delta/ (1/FRAMERATE)
#TODO: linear interpoiation
#	player.velocityPlayer.x = move_toward(abs(player.velocityPlayer.x), player.moveSpeed, amount) * player.moveDirection.x
#
#func apply_swim_friction(amount) -> void:
#	player.velocityPlayer.x = move_toward(player.velocityPlayer.x, 0, amount)

