extends Unlockables

export var augment: PackedScene


func _ready() -> void:
	connect("area_entered", self, "on_AugmentUnlocker_entered")

func on_AugmentUnlocker_entered(area: CollectorBox) -> void:
	EventBus.emit_signal("playerAugmentUnlocked", augment.instance())
