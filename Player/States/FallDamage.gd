extends MoveState


export (float, 0 , 1, 0.1) var recoverTime: float = 0.5
onready var recoverTimer: Timer = $Recover

func _ready() -> void:
	recoverTimer.wait_time = recoverTime

func enter() -> void:
	.enter()

	recoverTimer.start()
	player.fallDamge = false


func exit() -> void:
	.exit()

	


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

	if recoverTimer.is_stopped():
		return State.Idle

	return State.Null
