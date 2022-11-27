 extends DashState

#LOOKAT: umlimited uses?
onready var onFloorTimer: Timer = $OnFloor
var onFloorTime: float = 0.5


func enter() -> void:
	.enter()

	onFloorTimer.wait_time = onFloorTime
	player.animPlayer.play("Dash Down")
	player.set_collision_mask_bit(CollisionLayers.DashDown, false)
	onFloorTimer.start()


func exit() -> void:
	.exit()

	player.animPlayer.stop()
	player.set_collision_mask_bit(CollisionLayers.DashDown, true)


func physics(delta) -> void:
	.physics(delta)

	player.move_logic(player.NO_SNAP, false)
	player.velocityPlayer.x = 0
	player.velocityPlayer.y = player.dashVelocity


func visual(delta) -> void:
	.visual(delta)

	


func handle_input(event: InputEvent) -> int:
	var newState = .handle_input(event)
	if newState:
		return newState

	if Input.is_action_just_pressed("dash"): 
		dash_pressed_buffer()
	if Input.is_action_just_pressed("jump"):
		if player.can_use_ability(PlayerAbilities.list.JumpAir):
			return State.JumpAir
		else:
			return State.Fall

	return State.Null


func state_check(delta: float) -> int:
	var newState = .state_check(delta)
	if newState:
		return newState

	if dashBufferState != BaseState.State.Null:
		if player.can_use_ability(PlayerAbilities.list.DashJump) and dashBufferState == BaseState.State.DashJump:
			return BaseState.State.DashJump
		if player.can_use_ability(PlayerAbilities.list.DashAir) and dashBufferState == BaseState.State.DashAir:
			return BaseState.State.DashAir
		if player.can_use_ability(PlayerAbilities.list.DashUp) and dashBufferState == BaseState.State.DashUp:
			return BaseState.State.DashUp
		if player.can_use_ability(PlayerAbilities.list.DashDown) and dashBufferState == BaseState.State.DashDown:
			return BaseState.State.DashDown
	if onFloorTimer.is_stopped() and player.is_on_floor():
		return State.Idle
		#TODO add stun state

	return State.Null
