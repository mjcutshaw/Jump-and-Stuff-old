extends PlayerAbilitiesNode
class_name Player


onready var sm: Node = $StateMachine
onready var characterRig: Node2D = $CharacterRig
onready var stateLabel: Label = $StateLabel
onready var animPlayer: AnimationPlayer = $CharacterRig/AnimationPlayer
onready var ledgeDetectionLeft: RayCast2D = $Raycasts/LedgeDetection/Left
onready var ledgeDetectionRight: RayCast2D = $Raycasts/LedgeDetection/Right

const FLOOR_NORMAL = Vector2.UP
const SNAP_GROUND:= Vector2(0, 20.0)
const SNAP_Wall:= Vector2(20.0, 0) ##TODO: multiply times wall direction
const NO_SNAP:= Vector2.ZERO

var velocity: Vector2 = Vector2.ZERO
var velocityPlayer: Vector2 = Vector2.ZERO
var velocityEnviroment: Vector2 = Vector2.ZERO
var velocityAugment: Vector2 = Vector2.ZERO

var ledgeLeft: bool = false
var ledgeRight: bool = false



func _ready() -> void:
	sm.init()
	EventBus.connect("playerDied", self, "died")



func _unhandled_input(event: InputEvent) -> void:
	sm.handle_input(event)


func _physics_process(delta: float) -> void:
	sm.physics(delta)
	sm.state_check(delta)
	ledge_detection()
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


func died() -> void:
	pass

func ledge_detection()-> void:
	if is_on_floor() and !ledgeDetectionLeft.is_colliding():
		ledgeLeft = true
	else:
		ledgeLeft = false
	
	if is_on_floor() and !ledgeDetectionRight.is_colliding():
		ledgeRight = true
	else:
		ledgeRight = false
