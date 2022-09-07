extends MoveState
class_name SwimState

#TODO: turn into super swim state
#TODO: water dash

var isSurfacing: bool = false

func enter() -> void:
	.enter()

	player.swimLevel.enabled = true
	player.animPlayer.play("Slide")


func exit() -> void:
	.exit()

	player.swimLevel.enabled = false


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, false)
	
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

	player.turn_sprite()


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if isSurfacing and Input.is_action_just_pressed("jump"):
		return State.Jump
	#TODO: jump in water for up thrust

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.inWater == false:
		return State.Fall

	return State.Null


func swim_velocity_logic(speed: int) -> void:
	#TODO: accel and friction
	player.velocityPlayer = player.moveDirection * speed

func handle_surfacing(delta) -> void:
	if player.velocity.y < 0:
		pass

#func apply_swim_acceleration(amount) -> void:
#TODO: need to multiply times delta/ (1/FRAMERATE)
#	player.velocityPlayer.x = move_toward(abs(player.velocityPlayer.x), player.moveSpeed, amount) * player.moveDirection.x
#
#func apply_swim_friction(amount) -> void:
#	player.velocityPlayer.x = move_toward(player.velocityPlayer.x, 0, amount)

