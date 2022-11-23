extends MoveState
#TODO: create
#TODO: dive through water, sand and snow. waterfall

func enter() -> void:
	.enter()

	player.set_collision_mask_bit(CollisionLayers.BURROW, false)


func exit() -> void:
	.exit()

	player.set_collision_mask_bit(CollisionLayers.BURROW, true)


func physics(delta) -> void:
	.physics(delta)

	


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

	

	return State.Null
