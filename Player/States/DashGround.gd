extends DashState

# Wave/SuperWave dash like Celeste
export (float, 0 , 0.3, 0.05) var dashJumpTime: float = .1
onready var dashJumpTimer: Timer = $DashJumpTimer
export (float, 0 , 0.3, 0.05) var dashJumpRefreshTime: float = .2
onready var dashJumpRefreshTimer: Timer = $DashJumpRefreshTimer

func _ready() -> void:
	dashJumpTimer.wait_time = dashJumpTime
	dashJumpTimer.one_shot = true
	dashJumpRefreshTimer.wait_time = dashJumpRefreshTime
	dashJumpRefreshTimer.one_shot = true

func enter() -> void:
	.enter()

	player.velocityPrevious = player.velocityPlayer
	EventBus.emit_signal("playerDashed")
	rotate_to_normal()
	player.dashTimer.start()
	dashJumpTimer.start()
	dashJumpRefreshTimer.start()
	player.animPlayer.play("Dash Ground")


func exit() -> void:
	.exit()

	if player.is_on_floor():
		if dashJumpTimer.is_stopped() and dashJumpRefreshTimer.is_stopped():
				player.velocityPlayer.x = player.velocityPrevious.x
		elif !dashJumpTimer.is_stopped() and !dashJumpRefreshTimer.is_stopped():
				player.consume_ability(Globals.abiliyList.Dash, 1)
	if !player.is_on_floor():
		player.consume_ability(Globals.abiliyList.Dash, 1)
		if player.moveDirection.x != 0:
			player.velocityPlayer.x = player.velocityPrevious.x
	player.animPlayer.stop()


func physics(delta) -> void:
	.physics(delta)

	player.velocityPlayer.x = player.dashVelocity * player.facing


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump") and !dashJumpRefreshTimer.is_stopped():
		return State.Jump

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if player.dashTimer.is_stopped():
		if player.is_on_floor():
			return State.Walk
		else:
			return State.Fall

	return State.Null
