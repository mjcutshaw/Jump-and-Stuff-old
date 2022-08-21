extends Button

func _ready() -> void:
	grab_focus()

func _on_Play_pressed() -> void:
	get_tree().change_scene("res://Levels/Playground/Playground.tscn")
