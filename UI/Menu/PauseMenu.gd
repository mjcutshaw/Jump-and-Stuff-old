extends BaseMenu

func enter() -> void:
	set_paused(true)
	self.visible = true

func exit() -> void:
	set_paused(false)
	self.visible = false

func handle_input(event: InputEvent) -> int:
	if Input.is_action_just_pressed("ui_pause"):
		return State.Unpaused
	
	return State.Null
