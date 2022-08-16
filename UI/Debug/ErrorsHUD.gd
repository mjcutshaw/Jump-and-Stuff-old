extends MarginContainer
#FIXME: only shows one line
#TODO: make debug overlay
onready var errorText: TextEdit = $TextEdit

func _ready() -> void:
	hide()
	EventBus.connect("error", self, "enter_text")

func enter_text(info) -> void:
	show()
	errorText.text = info
