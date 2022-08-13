extends Area2D
class_name Hurtbox


func _init() -> void:
	monitorable = false
	collision_layer = Globals.HURTBOX

func _ready() -> void:
	connect("area_entered", self, "_on_Hurtbox_entered")

func _on_Hurtbox_entered(hitbox: Hitbox) -> void:
	if owner.is_in_group("Player"):
		EventBus.emit_signal("playerHealthChanged", -hitbox.damage)
	else:
		owner.change_health(-hitbox.damage)
