extends Button

func _ready() -> void:
	connect("pressed", self, "button_pressed")

func button_pressed() -> void:
	EventBus.emit_signal("returnToGame")
