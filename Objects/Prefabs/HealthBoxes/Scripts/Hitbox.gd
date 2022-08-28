extends Interactable
class_name Hitbox

#TODO: hit/hurt boxes shoudn't be under interactables
#TODO: use tween to smooth out
export var iFrames: float = 1

func _ready() -> void:
	connect("area_entered", self, "_on_Healthbox_entered")

func _on_Healthbox_entered(healthbox: HealthBox) -> void:
	owner.change_health(healthbox.amount)
	#TODO: move player
	if owner.health > 0 and healthbox.amount < 0:
		#TODO: move to character rig
		set_deferred("monitoring", false)
		owner.modulate.a = 0.5 if Engine.get_frames_drawn() % 2 == 0 else 1.0
		yield(get_tree().create_timer(iFrames),"timeout")
		set_deferred("monitoring", true)
		owner.modulate.a = 1.0
	
