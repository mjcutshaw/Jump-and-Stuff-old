extends MarginContainer
#FIXME: fix margins
#TODO: make debug overlay
onready var errorText: TextEdit = $MarginContainer/TextEdit

func _ready() -> void:
	hide()
	EventBus.connect("error", self, "enter_text")

func enter_text(info) -> void:
	show()
	errorText.text = str(errorText.text, "\n", info)
	errorText.set_v_scroll(9999999)
