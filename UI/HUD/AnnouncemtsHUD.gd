extends MarginContainer


onready var announceLabel: Label = $Label
export var annoucmentLenght: float = 2.0


func _ready() -> void:
	hide()
	EventBus.connect("playerStatChange", self, "announce_stat_change")

func announce(type: String, amount: int) -> void:
	show()
	announceLabel.text = str(type + str(amount))
	yield(get_tree().create_timer(annoucmentLenght),"timeout")
	announceLabel.text = ""
	hide()


func announce_stat_change(stat: int, amount: int) -> void:
	if stat == Globals.statList.MoveSpeed:
		announce("Move speed inscreased by ", amount)
	elif stat == Globals.statList.JumpHeight:
		announce("Jump height inscreased by ", amount)
	elif stat == Globals.statList.HealthMax:
		announce("Max health inscreased by ", amount)
	else:
		EventBus.emit_signal("error", str("stat change error: ", stat))
	

