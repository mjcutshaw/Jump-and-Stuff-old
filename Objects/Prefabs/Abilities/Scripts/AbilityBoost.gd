extends AbilityBlockBase

export var boostAmount: int = 2

func _ready() -> void:
	connect("body_entered", self, "_on_boost_entered")
	if ability == abiliyList.All:
		set_collision_mask_bit(CollisionLayers.INTERACTABLE, true)
	elif ability == abiliyList.DashSide:
		set_collision_mask_bit(CollisionLayers.DashSide, true)
	elif ability == abiliyList.DashUp:
		set_collision_mask_bit(CollisionLayers.DashUp, true)
	elif ability == abiliyList.DashDown:
		set_collision_mask_bit(CollisionLayers.DashDown, true)
	elif ability == abiliyList.HookShot:
		set_collision_mask_bit(CollisionLayers.HookShot, true)
	elif ability == abiliyList.Burrow:
		set_collision_mask_bit(CollisionLayers.Burrow, true)
	elif ability == abiliyList.SwimDash:
		set_collision_mask_bit(CollisionLayers.SwimDash, true)
	else:
		if ability != abiliyList.null:
			EventBus.emit_signal("error", "Ability Boost error for " + str(ability) +" at: "  + str(name) + " at " + str(global_position))

func _on_boost_entered(body: Player) -> void:
	body.velocityPlayer.x = body.velocityPlayer.x * boostAmount
#	EventBus.emit_signal("error", "boosted")
