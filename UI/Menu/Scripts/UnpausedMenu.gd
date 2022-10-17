extends BaseMenu

func enter() -> void:
	set_paused(false)

func exit() -> void:
	pass

func handle_input(event: InputEvent) -> BaseMenu:
	if Input.is_action_just_pressed("ui_pause"):
		return State.Paused
	if Input.is_action_just_pressed("fast_travel"):
		return State.FastTravel
	
	return State.Null

func state_check() -> BaseMenu:
	return State.Null
