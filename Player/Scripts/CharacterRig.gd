extends Node2D

onready var frame: Sprite = $Frame/GreenFrame
var transformTime: float = 0.2

func to_walk() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_parallel(true)
	tween.tween_property(frame, "position", Vector2(0,-79.423), transformTime).from_current()
	tween.tween_property(frame, "scale", Vector2(0.386, 1.153), transformTime).from_current()

func to_slide() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_parallel(true)
	tween.tween_property(frame, "position", Vector2(0,-47.712), transformTime).from_current()
	tween.tween_property(frame, "scale", Vector2(0.771,0.577), transformTime).from_current()

