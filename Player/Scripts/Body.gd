extends Node2D
tool

export var bodyHeight: int setget set_body_height
export var bodyWidth: int setget set_body_width
export var bodyColor: Color setget set_body_color

var height: int
var width: int
onready var bodySize: Vector2 = Vector2(width, height)


func _draw() -> void:
	## Body ##
	draw_rect(Rect2(Vector2(-32,0),bodySize), bodyColor)
	## Eye ##
	draw_circle(Vector2(16,-96), 4, Color.white)
	## Mouth ##
	draw_rect(Rect2(Vector2(8, -70),Vector2(24,4)), Color.white)

func set_body_height(v) -> void:
	bodyHeight = v
	height = -v * Globals.TILE_SIZE
	set_body_size()
	update()

func set_body_width(v) -> void:
	bodyWidth = v
	width = v * Globals.TILE_SIZE
	set_body_size()
	update()

func set_body_size() -> void:
	bodySize = Vector2(width, height)

func set_body_color(v) -> void:
	bodyColor = v
	update()
