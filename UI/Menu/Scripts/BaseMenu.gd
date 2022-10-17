extends Control
class_name BaseMenu

enum State{
	Null,
	Unpaused,
	Paused,
	Settings,
	FastTravel,
	}

var menu

func enter() -> void:
	pass

func exit() -> void:
	pass

func handle_input(event: InputEvent) -> BaseMenu:
	return State.Null


func set_paused(newPauseState) -> void:
	get_tree().paused = newPauseState
