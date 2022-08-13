extends Interactable
class_name Hitbox


func _init() -> void:
	set_collision_layer_bit(Globals.HITBOX, true)

func _ready() -> void:
	connect("area_entered", self, "_on_Hurtbox_entered")

func _on_Hurtbox_entered(healthbox: HealthBox) -> void:
	if owner.is_in_group("Player"):
		EventBus.emit_signal("playerHealthChanged", healthbox.amount)
	else:
		owner.change_health(healthbox.amount)
