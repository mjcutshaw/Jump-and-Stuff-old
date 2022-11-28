extends DashState
#TODO: create reverse versions of the jump
#TODO: make percent of dashDuraction, make stat increase based off fewer numbers
export (float, 0 , 0.3, 0.05) var dashJumpTime: float = .17
onready var dashJumpTimer: Timer = $DashJumpTimer
export (float, 0 , 0.3, 0.05) var dashJumpRefreshTime: float = .22
onready var dashJumpRefreshTimer: Timer = $DashJumpRefreshTimer
var superJump: bool = false

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
	player.set_collision_layer_bit(CollisionLayers.DashSide, true)
	player.set_collision_mask_bit(CollisionLayers.DashSide, false)
	player.velocityPlayer.x = player.dashVelocity * player.facing


func exit() -> void:
	.exit()

	if player.is_on_floor():
		if superJump: ## dash jump with dash count reset
			player.dashCDTimer.stop()
#			EventBus.emit_signal("error", "ultra jump")
		else:## dash jump 
			player.consume_ability(PlayerAbilities.list.DashAir, 1)
			if !dashJumpTimer.is_stopped():
#				EventBus.emit_signal("error", "early jump")
				player.velocityPlayer.x = player.velocityPlayer.x/4
#			else:
#				EventBus.emit_signal("error", "super jump")
				
	elif !player.is_on_floor():
		player.consume_ability(PlayerAbilities.list.DashAir, 1)
		if player.moveDirection.x != 0:
			player.velocityPlayer.x = player.velocityPrevious.x
	
	player.animPlayer.stop()
	superJump = false
	player.set_collision_layer_bit(CollisionLayers.DashSide, false)
	player.set_collision_mask_bit(CollisionLayers.DashSide, true)


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.SNAP_GROUND, true)
	


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("jump"):
		if dashJumpRefreshTimer.is_stopped():
			superJump = true
		else:
			superJump = false
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
