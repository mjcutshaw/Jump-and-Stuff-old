extends Area2D
class_name Interactable

export var oneUse: bool = false
#TODO: add use amounts
#TODO: Magnetize pickups to player

func _ready() -> void:
	connect("body_entered", self, "_on_Interactable_entered")


func _on_Interactable_entered(body: Player) -> void:
	if oneUse:
		queue_free()
