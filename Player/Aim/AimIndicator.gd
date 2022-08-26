tool
extends Node2D

export var center: Vector2 = Vector2(50,0)
export var radius: int = 14
export var color: Color = Color.green
export var width: int = 8

func _draw():
	draw_arc(center, radius, -360, 360, 3, color, width)
