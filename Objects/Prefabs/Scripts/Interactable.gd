extends Area2D
class_name Interactable

func _ready() -> void:
	collision_layer = Globals.INTERACTABLE
	collision_mask = Globals.PLAYER
