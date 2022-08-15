extends Hitbox
class_name HitboxPlayer


func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(area: Interactable) -> void:
	if area is Hurtbox or HealBox:
		EventBus.emit_signal("playerHealthChanged", area.amount)
	if area is StatChanger:
		EventBus.emit_signal("playerStatChange", area.statIncrease, area.amount)
		area.queue_free()

