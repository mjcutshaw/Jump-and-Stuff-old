extends WallState

#TODO: remove

func enter() -> void:
	.enter()

	#TODO: animation
	player.animPlayer.play("Wall Climb")


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	player.velocityPlayer.x = 0
	player.velocityPlayer.y = player.moveDirection.y * player.moveSpeed * .5


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_released("grab"):
		return State.WallSlide

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.moveDirection.y == 0 and player.can_use_ability(PlayerAbilities.list.Grab):
		return State.WallGrab

	return State.Null
