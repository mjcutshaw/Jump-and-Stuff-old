extends Unlockables
class_name AbilitiyUnlocker

export (PlayerAbilities.list) var ability
#var Abilities: Resource = preload("res://Resources/PlayerAbilities.tres")

#TODO: redundent could could be merge for unlockers

func _ready() -> void:
	connect("area_entered", self, "on_Player_entered")
	
	if ability == PlayerAbilities.list.null:
		EventBus.emit_signal("error", str("ability unlocker null: " + str(name) + " at " + str(global_position)))

func on_Player_entered(area: CollectorBox) -> void:
	EventBus.emit_signal("playerAbilityUnlocked", ability)

