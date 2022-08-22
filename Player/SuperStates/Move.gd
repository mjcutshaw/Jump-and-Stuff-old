extends BaseState
class_name MoveState

#FIXME: don't exit super state if it is the same

var neutralMovement: bool = false


func enter() -> void:
	.enter()

	


func exit() -> void:
	.exit()

	


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


func gravity_logic(amount, delta) -> void:
	player.velocityPlayer.y += amount * delta


func velocity_logic(speed) -> void:
	#TODO: variable to use moveDirection
	player.velocityPlayer.x = get_move_direction().x * speed


func momentum_logic(speed, useMoveDirection: bool = true) -> void:
	#FIXME: redo this. not good velocity mechanic
	if useMoveDirection:
		player.velocityPlayer.x = get_move_strength().x * max(abs(speed), abs(player.velocityPlayer.x))
	if !useMoveDirection:
		if player.velocityPlayer.x == 0:
			player.velocityPlayer.x = player.velocityPlayer.x
		else:
			player.velocityPlayer.x =  max(abs(speed), abs(player.velocityPlayer.x)) * sign(player.velocityPlayer.x) 


func apply_acceleration(amount) -> void:
	player.velocityPlayer.x = move_toward(abs(player.velocityPlayer.x), player.moveSpeed, amount) * get_move_direction().x

func apply_friction(amount) -> void:
	player.velocityPlayer.x = move_toward(player.velocityPlayer.x, 0, amount)


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


func rotate_to_normal() -> void:
	if player.rotation != 0*PI:
		var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		tween.tween_property(player, "rotation", 0*PI, .2)
