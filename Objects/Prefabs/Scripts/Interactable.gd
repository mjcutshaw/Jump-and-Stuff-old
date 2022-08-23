extends Area2D
class_name Interactable

## Create from prefab ##

export var oneUse: bool = false


func _ready() -> void:
	connect("body_entered", self, "_on_Interactable_entered")


func _on_Interactable_entered(body: Player) -> void:
	if oneUse:
		queue_free()
