extends Hitbox
class_name HitboxPlayer

#TODO turn into damage only
#func _ready() -> void:
#	connect("area_entered", self, "_on_HitboxPlayer_entered")
#
#func _on_HitboxPlayer_entered(area: Interactable) -> void:
#	if area.is_in_group("Healthbox"):
#		EventBus.emit_signal("playerHealthChanged", area.amount)
#		#TODO: look into the way bouncebox works
##	elif area.is_in_group("StatChanger") :
##		EventBus.emit_signal("playerStatChange", area.statIncrease, area.amount)

