extends BaseState
class_name MoveState


func enter() -> void:
	.enter()

	


func exit() -> void:
	.exit()

#	player.previousVelocity = player.velocity


func physics(delta) -> void:
	.physics(delta)

	
	player.velocity = player.velocity_logic()



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

	

	return State.Null


#TODO: move to player script 

func gravity_logic(amount, delta) -> void:
	player.velocityPlayer.y += amount * delta

func momentum_logic(speed, useMoveDirection: bool) -> void:
	#TODO: need to get accel and deccel, lerp function
	if useMoveDirection:
		player.velocity.x = player.moveDirection.x * max(abs(speed), abs(player.velocity.x))
	if !useMoveDirection:
		if player.velocity.x == 0:
			player.velocity.x = player.velocity.x
		else:
			player.velocity.x =  max(abs(speed), abs(player.velocity.x)) * player.facing

func neutral_move_direction_logic() -> bool:
	if get_move_direction() == Vector2.ZERO:
		return true
	return false

static func get_move_direction() -> Vector2:
	return get_move_strength().normalized()

static func get_move_strength() -> Vector2:
	var deadzoneRadius: = 0.2
	#TODO: make deadzone radius in settings
	var inputStrength: = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	return inputStrength if inputStrength.length() > deadzoneRadius else Vector2.ZERO
