extends Interactable
class_name AbilityBlockBase
#TODO: passage, hazard, portal, spring
#todo: look at grapple pulling wall in GDQuest platformer
enum abiliyList {
	null,
	All,
	JumpAir,
	DashAll,
	DashSide,
	DashUp,
	DashDown,
	HookShot,
	SwimDash,
	Burrow,
	}
#TODO: use "any" for default behaviour
export (abiliyList) var ability
#TODO: find better way than scaling the block
#export var height: int = 1
#export var width: int = 1

func _ready() -> void:
	if ability == abiliyList.All:
		modulate = Globals.allColor
	elif ability == abiliyList.DashSide:
		modulate = Globals.dashSideColor
	elif ability == abiliyList.DashUp:
		modulate = Globals.dashUpColor
	elif ability == abiliyList.DashDown:
		modulate = Globals.dashDownColor
	elif ability == abiliyList.HookShot:
		modulate = Globals.hookshotColor
	elif ability == abiliyList.Burrow:
		modulate = Globals.burrowColor
	elif ability == abiliyList.SwimDash:
		modulate = Globals.swim
	else:
		EventBus.emit_signal("error", str("Ability block color null: " + str(name) + " at " + str(global_position)))

	if ability == abiliyList.null:
		EventBus.emit_signal("error", str("Ability block null: " + str(name) + " at " + str(global_position)))
		
