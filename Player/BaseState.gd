extends Node
class_name BaseState

enum State {
	Null,
	Spawn,
	Die,
	Idle,
	Walk,
	Jump,
	Fall,
}

var player: Player
var Stats: = ResourceLoader.load("res://Resources/PlayerStats.tres")

func enter() -> void:
	pass

func exit() -> void:
	pass

func handle_input(event: InputEvent) -> int:
	return State.Null

func visual(delta: float) -> void:
	pass

func physics(delta: float) -> void:
	pass

func state_check(delta: float) -> int:
	return State.Null
