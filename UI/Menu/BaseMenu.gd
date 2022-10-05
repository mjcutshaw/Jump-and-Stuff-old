extends Control
class_name BaseMenu

enum State{
	Null,
	Unpaused,
	Paused,
	}

var menu

func enter() -> void:
	pass

func exit() -> void:
	pass

func handle_input(event: InputEvent) -> int:
	return State.Null


func set_paused(newPauseState) -> void:
	get_tree().paused = newPauseState
