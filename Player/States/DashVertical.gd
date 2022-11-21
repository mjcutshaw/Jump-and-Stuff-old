extends DashState

#LOOKAT: change to dash up
#FIXME: copied dashH
#if jumped pressed during wall bounce for extra height

func enter() -> void:
	.enter()

	
	EventBus.emit_signal("playerDashed")
	rotate_to_normal()
	player.dashTimer.start()
	player.velocityPlayer.y = -player.dashVelocity
	player.animPlayer.play("Dash Side")
	player.consume_ability(Globals.abiliyList.Dash, 1)


func exit() -> void:
	.exit()

	player.animPlayer.stop()


func physics(delta) -> void:
	.physics(delta)

	player.velocityPlayer.x = 0
	player.move_logic(player.NO_SNAP, true)


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
