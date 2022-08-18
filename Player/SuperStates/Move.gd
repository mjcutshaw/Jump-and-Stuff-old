extends BaseState
class_name MoveState

#FIXME: gut movement code and remake it

var neutralMovement: bool = false


func enter() -> void:
	.enter()

	


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	if get_move_direction().x == 0 and (player.ledgeLeft or player.ledgeRight):
		player.velocity.x = 0
		## stop on ledge it no input. might be better to change friction
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


func gravity_logic(amount, delta) -> void:
	player.velocityPlayer.y += amount * delta


func velocity_logic(speed) -> void:
	#TODO: variable to use moveDirection
	player.velocityPlayer.x = get_move_direction().x * speed


func momentum_logic(speed, useMoveDirection: bool = true) -> void:
	#FIXME: redo this. not good velocity mechanic
	if useMoveDirection:
		if player.velocityPlayer.x < player.moveSpeed:
			player.velocityPlayer.x = get_move_strength().x * round(lerp(abs(player.velocityPlayer.x), player.moveSpeed, player.acceleration))
		else:
			player.velocityPlayer.x = get_move_strength().x * max(abs(speed), abs(player.velocityPlayer.x))
	if !useMoveDirection:
		if player.velocityPlayer.x == 0:
			player.velocityPlayer.x = player.velocityPlayer.x
		else:
			player.velocityPlayer.x =  max(abs(speed), abs(player.velocityPlayer.x)) * sign(player.velocityPlayer.x) 

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
