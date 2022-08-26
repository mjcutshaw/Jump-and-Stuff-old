tool
extends Node2D

#TODO: tweak the z indux to show over stuff

export var radius: float = 14.0


func _ready() -> void:
	set_as_toplevel(true)
	update()


func _draw() -> void:
	draw_arc(Vector2(0, 0), radius, 1, 360, 10, Globals.grappleColor, 5)
