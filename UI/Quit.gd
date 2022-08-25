extends Button

func _ready() -> void:
	connect("pressed", self, "_on_Quit_pressed")

func _on_Quit_pressed() -> void:
	get_tree().quit()
