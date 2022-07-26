extends Node
#TODO: look into gdquest state machine
#TODO: state machine based of signals
onready var states = {
	BaseState.State.Spawn: $Spawn,
	BaseState.State.Teleport: $Teleport,
	BaseState.State.Die: $Die,
	BaseState.State.Idle: $Idle,
	BaseState.State.Walk: $Walk,
	BaseState.State.Jump: $Jump,
	BaseState.State.JumpAir: $JumpAir,
	BaseState.State.JumpWall: $JumpWall,
	BaseState.State.JumpReverse: $JumpReverse,
	BaseState.State.Apex: $Apex,
	BaseState.State.Fall: $Fall,
	BaseState.State.DashGround: $DashGround,
	BaseState.State.DashAir: $DashAir,
	BaseState.State.DashUp: $DashUp,
	BaseState.State.DashDown: $DashDown,
	BaseState.State.DashJump: $DashJump,
	BaseState.State.DashWall: $DashWall,
	BaseState.State.DashClimb: $DashClimb,
	BaseState.State.Glide: $Glide,
	BaseState.State.WallSlide: $WallSlide,
	BaseState.State.WallGrab: $WallGrab,
	BaseState.State.WallClimb: $WallClimb,
	BaseState.State.HookShot: $HookShot,
	BaseState.State.Swim: $Swim,
	BaseState.State.SwimDash: $SwimDash,
	BaseState.State.Skid: $Skid,
	BaseState.State.FallDamage: $FallDamage,
	BaseState.State.Bonk: $Bonk,
}

var currentState: BaseState
var previousState: BaseState
var currentStateName: String
var previousStateName: String

onready var player: Player = owner

func _ready() -> void:
	EventBus.connect("playerDied", self, "player_died")
	EventBus.connect("playerBounced", self, "bounce")
	EventBus.connect("playerTeleported", self, "player_teleported")

func change_state(newState: int) -> void:
	if currentState:
		currentState.exit()
		previousState = currentState
		previousStateName = previousState.name
		player.previousState = currentState
	
	currentState = states[newState]
	currentState.enter()
	currentStateName = currentState.name
	EventBus.emit_signal("debugState", currentStateName)
#	EventBus.emit_signal("error", currentStateName)
	#TODO: create log instead of error


func init() -> void:
	for child in get_children():
		child.player = player

	change_state(BaseState.State.Spawn)

func handle_input(event: InputEvent) -> void:
	var newState = currentState.handle_input(event)
	if newState != BaseState.State.Null:
		change_state(newState)


func physics(delta) -> void:
	currentState.physics(delta)


func state_check(delta) -> void:
	var newState = currentState.state_check(delta)
	if newState != BaseState.State.Null:
		change_state(newState)


func visual(delta) -> void:
	currentState.visual(delta)


#func sound(delta) -> void:
#	currentState.sound(delta)

func player_teleported() -> void:
	change_state(BaseState.State.Teleport)

func player_died() -> void:
	change_state(BaseState.State.Die)

func bounce(amount) -> void:
	change_state(BaseState.State.Fall)
	player.velocityPlayer = amount
	#TODO: lower amount if jump is no pressed
