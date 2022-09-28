extends MoveState
class_name DashState

#TODO: shrink hitbox
#TODO: move modifiers to states
#FIXME: turn dash inputs into dash + direction
#TODO: cooldown timers

func enter() -> void:
	.enter()

	


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.SNAP_GROUND, true)


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

	if player.coyoteJumpWallTimer.is_stopped() and player.is_on_wall():
		return State.WallSlide

	return State.Null
