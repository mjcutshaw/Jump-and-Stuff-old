extends BaseMenu

func enter() -> void:
	set_paused(false)

func exit() -> void:
	set_paused(true)

func handle_input(event: InputEvent) -> int:
	if Input.is_action_just_pressed("ui_pause"):
		return State.Paused
	
	return State.Null
