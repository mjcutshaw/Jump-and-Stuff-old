extends Line2D

onready var timer: Timer = $Timer
onready var start_length: float = position.x
export var duration: float = 2.0
export var drawTime: float = 0.25

var startingPosition: Vector2 = Vector2.ZERO
#LOOKAT: changing starting position
#var targetPosition: = Vector2.ZERO setget set_line_position
##var length: = 40.0 setget set_length


func _ready() -> void:
	timer.connect("timeout", self, "hide_line")
	timer.wait_time = duration


func hide_line() -> void:
	visible = false
	

func set_target_position(targetPosition: Vector2) -> void:
	#FIXME: figure out how to convert global to local
	points[1] = targetPosition
	set_point_position(1, targetPosition)
	EventBus.emit_signal("debug2", "draw to: ", targetPosition)
	visible = true
	timer.start()

#func set_line_position(value: Vector2) -> void:
##	points[0] = startingPosition
#	EventBus.emit_signal("debug2", "draw to: ", targetPosition)
#	points[-1] = targetPosition
##	rotation = to_target.angle()
##	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
##	tween.tween_property(self, "length", length, drawTime).from(start_length)
	


#func set_length(value: float) -> void:
#	length = value
#	points[-1].x = length
##	head.position.x = line.points[-1].x + line.position.x
