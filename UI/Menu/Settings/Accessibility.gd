extends VBoxContainer

onready var aimArrowCheckBox: CheckBox = $"%AimArrowCheck"
var SettingsFile: Resource = preload("res://Resources/SettingsFile.tres")

func _ready() -> void:
	aimArrowCheckBox.connect("toggled", self, "show_aim_arrow")
	update_menu()

func update_menu() -> void:
	aimArrowCheckBox.pressed = SettingsFile.showAimIndicator

func show_aim_arrow(toggled) -> void:
	SettingsFile.showAimIndicator = toggled
