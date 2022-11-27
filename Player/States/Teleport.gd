extends BaseState

export var growTime: float = .5

func enter() -> void:
	.enter()

	player.lastDirection.x = player.facing
	EventBus.emit_signal("playerSpawned")
	player.animPlayer.play("Spawn")
	EventBus.emit_signal("playerHealthChanged", player.healthMax)
	player.reset_ability(PlayerAbilities.list.All)


func exit() -> void:
	.exit()

	player.characterRig.scale = Vector2(1,1)


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

#	#TODO: more ability triggerable or chnage to idle after timer/animation
#	if player.is_on_floor():
#		if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
#			return State.Walk
#		if Input.is_action_just_pressed("jump"):
#			return State.Jump
#		if Input.is_action_just_pressed("dash") and player.can_use_ability(PlayerAbilities.list.DashGround):
#			return State.DashGround

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.is_on_floor():
		return State.Spawn

	return State.Null
