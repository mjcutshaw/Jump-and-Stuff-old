extends Interactable
class_name Target


export (Globals.abilityTargetType) var abilityTarget
onready var timer: Timer = $Timer



#TODO: color based on ability
export var COLOR_ACTIVE: Color = Color(0.9375, 0.730906, 0.025635)
export var COLOR_INACTIVE: Color = Color(0.515625, 0.484941, 0.4552)

var is_active: = true setget set_is_active
var color: = COLOR_ACTIVE setget set_color


func _ready() -> void:
	timer.connect("timeout", self, "_on_Timer_timeout")
	if abilityTarget == Globals.abilityTargetType.null:
		EventBus.emit_signal("error", str("null target type" + str(global_position)))
	if abilityTarget == Globals.abilityTargetType.hookShot:
		set_collision_layer_bit(CollisionLayers.HOOKSHOT, true)
	if abilityTarget == Globals.abilityTargetType.grappleHook:
		set_collision_layer_bit(CollisionLayers.GRAPPLEHOOK, true)
	if abilityTarget == Globals.abilityTargetType.burrow:
		set_collision_layer_bit(CollisionLayers.BURROW, true)

func _draw() -> void:
	draw_circle(Vector2.ZERO, 12.0, color)


func _on_Timer_timeout() -> void:
	self.is_active = true

func hooked() -> void:
	is_active = false
	
func hooked_from(hook_position: Vector2) -> void:
	self.is_active = false
	emit_signal("hooked_onto_from", hook_position)


func set_is_active(value:bool) -> void:
	is_active = value
	self.color = COLOR_ACTIVE if is_active else COLOR_INACTIVE

	if not is_active and not oneUse:
		timer.start()


func set_color(value:Color) -> void:
	color = value
	update()
