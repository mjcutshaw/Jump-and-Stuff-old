extends Unlockables
class_name StatChanger


export (Globals.statList) var statIncrease
export var amount: int = 1
export var negative: bool = false

func _ready() -> void:
	if negative:
		amount = -amount
	if statIncrease == Globals.statList.null:
		EventBus.emit_signal("error", str("stat changer null: " + str(name) + " at " + str(global_position)))
	
	connect("area_entered", self, "on_Player_entered")


func on_Player_entered(area: CollectorBox) -> void:
	EventBus.emit_signal("playerStatChange", statIncrease, amount)

	
