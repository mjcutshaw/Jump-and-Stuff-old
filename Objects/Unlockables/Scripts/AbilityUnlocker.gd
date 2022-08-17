extends Unlockables
class_name AbilitiyUnlocker


export var ability: PackedScene

#TODO: redundent could could be merge for unlockers

func _ready() -> void:
	connect("area_entered", self, "on_AbilitytUnlocker_entered")

func on_AbilitytUnlocker_entered(area: HitboxPlayer) -> void:
	EventBus.emit_signal("playerAbilityUnlocked", ability.instance())
