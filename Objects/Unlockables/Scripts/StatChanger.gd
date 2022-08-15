extends Unlockables
class_name StatChanger

enum Stats{moveSpeed, jumpHeight, healthMax}
export (Stats) var statIncrease
export var amount: int = 1
export var negative: bool = false

func _ready() -> void:
	if negative:
		amount = -amount
