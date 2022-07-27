extends Node


onready var states = {
	BaseState.State.Spawn: $Spawn,
	BaseState.State.Die: $Die,
	BaseState.State.Idle: $Idle,
	BaseState.State.Walk: $Walk,
	BaseState.State.Jump: $Jump,
	BaseState.State.Fall: $Fall,
}

var currentState: BaseState
var previousState: BaseState
var currentStateName: String
var previousStateName: String

onready var player: Player = get_parent()


func change_state(newState: int) -> void:
	if currentState:
		currentState.exit()
		previousState = currentState
		previousStateName = previousState.name
	
	currentState = states[newState]
	currentState.enter()
	currentStateName = currentState.name
	player.stateLabel.text = currentState.name

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

