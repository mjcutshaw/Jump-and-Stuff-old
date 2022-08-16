extends BaseState


func enter() -> void:
	.enter()

	#todo: particles and timout out to respawn


func exit() -> void:
	.exit()

	
	if CheckpointSystem.currentRespawn != Vector2.ZERO:
		player.global_position = CheckpointSystem.currentRespawn
	else:
		get_tree().reload_current_scene()
		EventBus.emit_signal("error", str("no spawn point set"))


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

	#TODO: make a timer
	return State.Spawn

	return State.Null
