extends Unlockables

export var augment: PackedScene


func _ready() -> void:
	connect("body_entered", self, "on_AugmentUnlocker_entered")

func on_AugmentUnlocker_entered(body: Player) -> void:
	EventBus.emit_signal("playerAugmentUnlocked", augment.instance())
