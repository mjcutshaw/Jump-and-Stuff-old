extends DashState

#TODO: move timer to here
#LOOKAT: see in need dash air group

var dashDirection

func enter() -> void:
	.enter()

	if sign(player.velocity.x) != 0:
		dashDirection = sign(player.velocity.x)
	else:
		dashDirection = player.facing
		
	player.velocityPlayer.y = 0
	player.velocityPrevious = player.velocityPlayer
	EventBus.emit_signal("playerDashed")
	rotate_to_normal()
	player.dashTimer.start()
	player.animPlayer.play("Dash Side")
	player.consume_ability(Globals.abiliyList.Dash, 1)


func exit() -> void:
	.exit()

	if player.moveDirection != Vector2.ZERO:
		player.velocityPlayer.x = player.velocityPrevious.x
	player.animPlayer.stop()


func physics(delta) -> void:
	.physics(delta)

	player.velocityPlayer.x = player.dashVelocity * dashDirection


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump") and player.can_use_ability(Globals.abiliyList.JumpAir):
		apply_acceleration(player.moveSpeed)
		return State.JumpAir

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.dashTimer.is_stopped():
		if player.is_on_floor():
			return State.Walk
		else:
			return State.Fall

	return State.Null
