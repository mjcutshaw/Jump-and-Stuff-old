extends BaseState

var growTime: float = .05

func enter() -> void:
	.enter()

	var tween = create_tween()
	tween.tween_property(player.characterRig, "scale", Vector2(1,1), growTime).from(Vector2(0,0))
	## grows the player on spawn ##



func exit() -> void:
	.exit()

#	player.previousVelocity = player.velocity


func physics(delta) -> void:
	.physics(delta)

	if !player.is_on_floor():
		player.velocity.y += 100
		player.move_logic(delta, player.SNAP_GROUND)
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
