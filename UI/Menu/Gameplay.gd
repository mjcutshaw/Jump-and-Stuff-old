extends VBoxContainer

onready var timerCheck: CheckBox = $"%TimeCheck"
var SettingsFile: Resource = preload("res://Resources/SettingsFile.tres")

func _ready() -> void:
	timerCheck.connect("toggled", self, "show_timer")
	update_menu()

func update_menu() -> void:
	timerCheck.pressed = SettingsFile.showTimer

func show_timer(toggled) -> void:
	SettingsFile.showTimer = toggled
