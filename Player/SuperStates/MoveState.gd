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
	player.velocityPlayer.x = player.moveDirection.x * speed


func momentum_logic(speed, useMoveDirection: bool = true) -> void:
	#FIXME: redo this. not good velocity mechanic
	if useMoveDirection:
		player.velocityPlayer.x = player.moveStrength.x * max(abs(speed), abs(player.velocityPlayer.x))
	if !useMoveDirection:
		if player.velocityPlayer.x == 0:
			player.velocityPlayer.x = player.velocityPlayer.x
		else:
			player.velocityPlayer.x =  max(abs(speed), abs(player.velocityPlayer.x)) * sign(player.velocityPlayer.x) 


func apply_acceleration(amount) -> void:
	#FIXME: need to multiply times delta/ (1/FRAMERATE)
	player.velocityPlayer.x = move_toward(abs(player.velocityPlayer.x), player.moveSpeed, amount) * player.moveDirection.x

func apply_friction(amount) -> void:
	#FIXME: need to multiply times delta/ (1/FRAMERATE)
	player.velocityPlayer.x = move_toward(player.velocityPlayer.x, 0, amount)


func neutral_move_direction_logic() -> bool:
	if player.moveDirection == Vector2.ZERO:
		return true
	return false


func rotate_to_normal() -> void:
	if player.rotation != 0*PI:
		var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		tween.tween_property(player, "rotation", 0*PI, .5)
