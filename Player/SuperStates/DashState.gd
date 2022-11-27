extends MoveState
class_name DashState

#TODO: shrink hitbox
#TODO: move modifiers to states
#FIXME: turn dash inputs into dash + direction
#TODO: cooldown timers

func enter() -> void:
	.enter()

	player.dashCDTimer.start()
	player.dashContactTimer.start()
	player.dashTimer.start()


func exit() -> void:
	.exit()

	


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
