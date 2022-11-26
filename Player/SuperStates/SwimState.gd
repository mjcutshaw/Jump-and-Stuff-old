extends MoveState
class_name SwimState


func enter() -> void:
	.enter()

	player.swimLevel.enabled = true
	player.reset_ability(PlayerAbilities.list.All)


func exit() -> void:
	.exit()

	player.swimLevel.enabled = false


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, false)


func visual(delta) -> void:
	.visual(delta)

	player.turn_sprite()


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

#	if player.inWater == false:
#		return State.Fall

	return State.Null


func swim_velocity_logic(speed: int) -> void:
	#TODO: accel and friction
	player.velocityPlayer = player.moveDirection * speed

func handle_surfacing(delta) -> void:
	if player.velocityPlayer.y < 0:
		pass
