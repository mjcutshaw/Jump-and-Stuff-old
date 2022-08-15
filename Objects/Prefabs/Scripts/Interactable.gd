extends Area2D
class_name Interactable

func _init() -> void:
	set_collision_mask_bit(Globals.INTERACTABLE, true)
	set_collision_layer_bit(Globals.INTERACTABLE, true)

#TODO: remove this
