extends Interactable
class_name AbilityBlockBase
#TODO: passage, hazard, boost, hazard, portal, spring
#todo: look at grapple pulling wall in GDQuest platformer
enum abiliyList {
	null,
	DashSide,
	DashUp,
	DashDown,
	HookShot,
	SwimDash,
	Burrow,
	}
#TODO: use "any" for default behaviour
export (abiliyList) var ability

func _ready() -> void:
	if ability == abiliyList.null:
		EventBus.emit_signal("error", str("ability block null: " + str(name) + " at " + str(global_position)))
		
