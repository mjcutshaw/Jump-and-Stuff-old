extends BaseState


func enter() -> void:
	.enter()

	EventBus.emit_signal("playerSpawned")
	if CheckpointSystem.currentRespawn != Vector2.ZERO:
		player.global_position = CheckpointSystem.currentRespawn
	player.animPlayer.play("Idle")
	EventBus.emit_signal("playerHealthChanged", player.healthMax)
	#TODO: need if statement if after damage return to last platform
	player.reset_ability(Globals.abiliyList.All)


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	if !player.is_on_floor():
		player.velocity.y += 100
		player.move_logic(player.SNAP_GROUND, true)
	else:
		player.velocity = Vector2.ZERO


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		return State.Walk
	if Input.is_action_just_pressed("jump"):
		return State.Jump

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	

	return State.Null
