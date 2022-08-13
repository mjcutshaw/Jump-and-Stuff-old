extends Camera2D


func _ready() -> void:
	EventBus.connect("playerGrounded", self, "grounded")
	pass

func grounded(isGrounded):
	drag_margin_v_enabled = !isGrounded

