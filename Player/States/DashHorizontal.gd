extends DashState

#TODO: move timer to here
#TODO: capture previous velocity and return to that, unless nuetral

func enter() -> void:
	.enter()

	
	EventBus.emit_signal("playerDashed")
	rotate_to_normal()
	player.dashTimer.start()
	player.animPlayer.play("Dash Side")
	player.consume_ability(Globals.abiliyList.Dash, 1)


func exit() -> void:
	.exit()

	player.animPlayer.stop()


func physics(delta) -> void:
	.physics(delta)

	player.velocity.y = 0
	player.velocityPlayer.x = player.dashVelocity * player.facing


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

	if player.dashTimer.is_stopped():
		if player.is_on_floor():
			return State.Walk
		else:
			return State.Fall

	return State.Null
