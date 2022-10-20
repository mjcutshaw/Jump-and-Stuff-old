extends Button

func _ready() -> void:
	connect("pressed", self, "_on_button_pressed")

func _on_button_pressed() -> void:
	get_tree().change_scene("res://UI/MainMenu.tscn")
