extends HealthBox
class_name Hurtbox

#TODO: one shot spikes with dificulty flag
#TODO: return to last safe platform
#TODO: spikes only hit once till you leave

func _init() -> void:
	amount = -amount

