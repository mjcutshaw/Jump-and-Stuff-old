extends Interactable
class_name Hitbox

#FIXME: create hitbox for enemies


#func _ready() -> void:
#	connect("area_entered", self, "_on_area_entered")
#
#func _on_area_entered(healthbox: HealthBox) -> void:
#	if owner.is_in_group("Player"):
#		EventBus.emit_signal("playerHealthChanged", healthbox.amount)
#	else:
#		owner.change_health(healthbox.amount)
