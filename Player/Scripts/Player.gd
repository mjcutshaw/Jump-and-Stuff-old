extends PlayerAbilitiesNode
class_name Player


onready var sm: Node = $StateMachine
onready var characterRig: Node2D = $CharacterRig
onready var stateLabel: Label = $StateLabel
onready var animPlayer: AnimationPlayer = $CharacterRig/AnimationPlayer

const FLOOR_NORMAL = Vector2.UP
const SNAP_GROUND:= Vector2(20.0, 0)
const SNAP_Wall:= Vector2(0, 20.0)
const NO_SNAP:= Vector2.ZERO

var velocity: Vector2 = Vector2.ZERO
var velocityPlayer: Vector2 = Vector2.ZERO
var velocityEnviroment: Vector2 = Vector2.ZERO
var velocityAugment: Vector2 = Vector2.ZERO




func _ready() -> void:
	sm.init()
	yield(get_tree(), "idle_frame")
	EventBus.emit_signal("playerHealthMaxChanged", healthMax)
	EventBus.emit_signal("playerHealthChanged", healthMax)

func _unhandled_input(event: InputEvent) -> void:
	sm.handle_input(event)


func _physics_process(delta: float) -> void:
	sm.physics(delta)
	sm.state_check(delta)
	
	$Velocity.text = str(velocity.round())


func _process(delta: float) -> void:
	sm.visual(delta)
#	sm.sound(delta)


func move_logic(snap, stopOnSlope) -> void:
	#TODO: revisit when changing gravity
	velocity = move_and_slide_with_snap(velocity, snap, FLOOR_NORMAL, stopOnSlope, 4, 0.9)

func velocity_logic() -> Vector2:
	#TODO: probably need a better way to do this. need to figure good way for swapable abilities 
	return velocityPlayer + velocityEnviroment + velocityAugment
