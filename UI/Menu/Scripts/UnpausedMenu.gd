extends BaseMenu

func enter() -> void:
	set_paused(false)

func exit() -> void:
	pass

func handle_input(event: InputEvent) -> BaseMenu:
	if Input.is_action_just_pressed("ui_pause"):
		return State.Paused
	
	return State.Null
