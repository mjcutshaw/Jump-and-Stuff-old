extends Camera2D

#TODO: make good
#Vertical Look when in the air until past certain height. Helps land on platform
#Camera mice toward certain objects like checkpoint, split player and object 
#Camera lead based on velocity 



func _ready() -> void:
	EventBus.connect("playerGrounded", self, "grounded")
	pass

func grounded(isGrounded):
	drag_margin_v_enabled = !isGrounded

