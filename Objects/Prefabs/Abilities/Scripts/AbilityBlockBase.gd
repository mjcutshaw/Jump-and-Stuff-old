extends Interactable
class_name AbilityBlockBase

#todo: look at grapple pulling wall in GDQuest platformer
enum abiliyList {
	null,
	All,
	DashSide,
	DashUp,
	DashDown,
	HookShot,
	SwimDash,
	Burrow,
	}

export (abiliyList) var ability

func _ready() -> void:
	if ability == abiliyList.null:
		EventBus.emit_signal("error", str("ability block null: " + str(name) + " at " + str(global_position)))
		
