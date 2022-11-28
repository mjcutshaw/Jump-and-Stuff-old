extends Area2D
class_name Interactable

export var oneUse: bool = false
export var lockOut: bool = false
export var lockOutTime: float = 4.0

#TODO: Magnetize pickups to player

func _ready() -> void:
	connect("body_entered", self, "_on_Interactable_entered")
	if oneUse and lockOut:
		EventBus.emit_signal("error", str("Interactable block oneUse and lockOut selected: " + str(name) + " at " + str(global_position)))


func lock_out() -> void:
	var currentColor = modulate
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	modulate = Color.gray
	yield(get_tree().create_timer(lockOutTime), "timeout")
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)
	modulate = currentColor


func _on_Interactable_entered(body: Player) -> void:
	if oneUse:
		queue_free()
	elif lockOut:
		lock_out()
