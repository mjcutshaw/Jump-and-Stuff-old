extends DashState


func enter() -> void:
	.enter()

	
	player.velocityPlayer.x = -player.lastWallDirection * player.dashVelocity * 1.5
	#TODO: new animation
	player.animPlayer.play("Dash Side")


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, true)
	player.velocityPlayer.y = 0


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
		if player.can_use_ability(Globals.abiliyList.JumpAir):
			return State.JumpAir
		else:
			return State.Fall
	elif Input.is_action_just_pressed("glide"):
		return State.Glide

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.is_on_wall() and player.coyoteWallTimer.is_stopped():
		return State.Bonk

	return State.Null
