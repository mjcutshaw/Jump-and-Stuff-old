extends AirState
class_name JumpState


func enter() -> void:
	.enter()

	


func exit() -> void:
	.exit()

#	player.previousVelocity = player.velocity


func physics(delta) -> void:
	.physics(delta)

	gravity_logic(player.gravityJump, delta)


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

#	if Input.is_action_just_released("jump"):
#		print("jump release")
#		player.velocityPlayer.y = max(player.velocityPlayer.y, player.jumpHeightMin)
#		return State.Fall

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.velocityPlayer.y >= 0:
		return State.Fall

	return State.Null
