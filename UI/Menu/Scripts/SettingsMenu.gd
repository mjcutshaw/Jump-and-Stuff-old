extends BaseMenu

onready var backButton: Button = $"%Back"


func _ready() -> void:
	backButton.connect("pressed", self, "back_button_pressed")

func enter() -> void:
	set_paused(true)
	self.visible = true

func exit() -> void:
	self.visible = false

func handle_input(event: InputEvent) -> BaseMenu:
	if Input.is_action_just_pressed("ui_pause"):
		return State.Paused
	
	return State.Null


func back_button_pressed() -> void:
	EventBus.emit_signal("menuChanged", State.Paused)
