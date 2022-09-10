extends Interactable
class_name Target


export (Globals.abilityTargetType) var abilityTarget
onready var timer: Timer = $Timer

var colorActive: Color = Color.black
var colorInactive: Color = Color.gray

var isActive: bool = true 
var color: Color = colorActive


func _ready() -> void:
	timer.connect("timeout", self, "_on_Timer_timeout")
	if abilityTarget == Globals.abilityTargetType.null:
		EventBus.emit_signal("error", str("null target type" + str(global_position)))
	if abilityTarget == Globals.abilityTargetType.hookShot:
		set_collision_layer_bit(CollisionLayers.HOOKSHOT, true)
		colorActive = Globals.hookshotColor
	if abilityTarget == Globals.abilityTargetType.grappleHook:
		set_collision_layer_bit(CollisionLayers.GRAPPLEHOOK, true)
		colorActive = Globals.grappleColor
	if abilityTarget == Globals.abilityTargetType.burrow:
		set_collision_layer_bit(CollisionLayers.BURROW, true)
		colorActive = Globals.burrowColor
	
	color = colorActive


func _draw() -> void:
	draw_circle(Vector2.ZERO, 12.0, color)


func _on_Timer_timeout() -> void:
	self.isActive = true
	color = colorActive
	update()

func hooked() -> void:
	isActive = false
	color = colorInactive
	timer.start()
	update()
	
