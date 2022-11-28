extends AbilityBlockBase

func _ready() -> void:
	connect("body_entered", self, "_on_boost_entered")

func _on_boost_entered(body: Player) -> void:
	if ability == abiliyList.All:
		EventBus.emit_signal("playerAbilityReset", PlayerAbilities.list.All)
	elif ability == abiliyList.DashSide:
		EventBus.emit_signal("playerAbilityReset", PlayerAbilities.list.DashAir)
	elif ability == abiliyList.DashUp:
		EventBus.emit_signal("playerAbilityReset", PlayerAbilities.list.DashUp)
	elif ability == abiliyList.DashDown:
		EventBus.emit_signal("playerAbilityReset", PlayerAbilities.list.DashDown)
	elif ability == abiliyList.DashAll:
		EventBus.emit_signal("playerAbilityReset", PlayerAbilities.list.DashAll)
	elif ability == abiliyList.JumpAir:
		EventBus.emit_signal("playerAbilityReset", PlayerAbilities.list.JumpAir)
	else:
		if ability != abiliyList.null:
			EventBus.emit_signal("error", "Ability Reset error for " + str(ability) +" at: "  + str(name) + " at " + str(global_position))
	
	EventBus.emit_signal("error", "ability reset")
