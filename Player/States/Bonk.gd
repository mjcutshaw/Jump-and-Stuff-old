extends MoveState

#TODO: bonk super state

export var bounceBack: int = 400

export var bonkTime: float = 1.0
onready var bonkTimer: Timer = $Timer
var grounded: bool = false

func enter() -> void:
	.enter()

	grounded = false
	bonkTimer.wait_time = bonkTime
	player.velocityPlayer.x = bounceBack * player.lastWallDirection
	var tween = create_tween()
	tween.tween_property(player.characterRig, "scale", Vector2(0.2, 0.8), .05)


func exit() -> void:
	.exit()

	


func physics(delta) -> void:
	.physics(delta)

	gravity_logic(player.gravityFall, delta)
	terminal_velocity(player.terminalVelocity)
	player.move_logic(player.SNAP_GROUND, true)
	if player.is_on_floor():
		if bonkTimer.is_stopped() and grounded == false:
			bonkTimer.start()
			var tween = create_tween()
			tween.tween_property(player.characterRig, "scale", Vector2(1, 1), .5)
		player.velocityPlayer = Vector2.ZERO
		grounded = true


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

	if bonkTimer.is_stopped() and player.is_on_floor():
		return State.Idle

	return State.Null
