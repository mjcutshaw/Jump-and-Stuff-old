extends Area2D
class_name Hitbox

export var damage: int = 1

func _init() -> void:
	collision_layer = 0
	collision_mask = Globals.HURTBOX
