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

#TODO: global enum
func announce_stat_change(stat: int, amount: int) -> void:
	if stat == 0:
		announce("Move speed inscreased by ", amount)
	elif stat == 1:
		announce("Jump height inscreased by ", amount)
	elif stat == 2:
		announce("Max health inscreased by ", amount)
	else:
		announce("stat change error: ", stat)
	

