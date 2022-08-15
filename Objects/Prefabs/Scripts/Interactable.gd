extends Area2D
class_name Interactable

## Create from prefab ##

export var oneUse: bool = false


func _ready() -> void:
	connect("area_entered", self, "_on_Interactable_entered")


func _on_Interactable_entered(area) -> void:
	if area.is_in_group("Player") and oneUse:
		queue_free()
