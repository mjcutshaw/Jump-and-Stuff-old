extends PlayerAbilitiesNode
class_name Player


onready var sm: Node = $StateMachine
onready var characterRig: Node2D = $CharacterRig
onready var animPlayer: AnimationPlayer = $CharacterRig/AnimationPlayer
onready var ledgeDetectionLeft: RayCast2D = $Raycasts/LedgeDetection/Left
onready var ledgeDetectionRight: RayCast2D = $Raycasts/LedgeDetection/Right

onready var bufferJumpTimer: Timer = $Timers/BufferJump
onready var coyoteJumpTimer: Timer = $Timers/CoyoteJump
onready var coyoteJumpWallTimer: Timer = $Timers/CoyoteJumpWall
onready var dashTimer: Timer = $Timers/DashDuration
onready var semisolidResetTimer: Timer = $Timers/SemisolidReset

const FLOOR_NORMAL = Vector2.UP
const SNAP_GROUND:= Vector2(0, 20.0)
const SNAP_Wall:= Vector2(20.0, 0) ##TODO: multiply times wall direction
const NO_SNAP:= Vector2.ZERO

var velocity: Vector2 = Vector2.ZERO
var velocityPlayer: Vector2 = Vector2.ZERO
var velocityEnviroment: Vector2 = Vector2.ZERO
var velocityAugment: Vector2 = Vector2.ZERO

var moveStrength: Vector2 = Vector2.ZERO
var moveDirection: Vector2 = Vector2.ZERO
var lastDirection: Vector2 = Vector2.ZERO
var facing: int = 1

var aimStrength: Vector2 = Vector2.ZERO
var aimDirection: Vector2 = Vector2.ZERO

var ledgeLeft: bool = false
var ledgeRight: bool = false

var jumpBufferTime: float = 0.1
var coyoteTime: float = 0.1
var semisolidResetTime:= .1

var jumpCornerCorrectionVertical: int = 10
var jumpCornerCorrectionHorizontal: int = 15

var glidePressed: bool = false


func _ready() -> void:
	sm.init()
	EventBus.connect("playerDied", self, "died")
	set_timers()


func _unhandled_input(event: InputEvent) -> void:
	sm.handle_input(event)
	
	#LookAt: move other actions to this
	if Input.is_action_pressed("glide"):
		glidePressed = true
	if Input.is_action_just_released("glide"):
		glidePressed = false


func _physics_process(delta: float) -> void:
	sm.physics(delta)
	sm.state_check(delta)
	get_move_input()
	ledge_detection()
	EventBus.emit_signal("debugVelocity", velocity.round())


func _process(delta: float) -> void:
	sm.visual(delta)
#	sm.sound(delta)


func move_logic(snap, stopOnSlope) -> void:
	#TODO: revisit when changing gravity
	velocity = move_and_slide_with_snap(velocity, snap, FLOOR_NORMAL, stopOnSlope, 4, 0.9)
	
	#TODO: play with using this on ground, go around circles
#	velocity = move_and_slide_with_snap(velocity.rotated(rotation), snap, -transform.y, stopOnSlope, 4, 0.9)

func get_move_input() -> void:
	var deadzoneRadius: float = 0.2
	#TODO: make deadzone radius in settings
	var inputStrength: = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	moveStrength =  inputStrength if inputStrength.length() > deadzoneRadius else Vector2.ZERO
	
	moveDirection =  moveStrength.normalized()
	
	if moveDirection != Vector2.ZERO:
		lastDirection = moveDirection


func velocity_logic() -> Vector2:
	#TODO: probably need a better way to do this. need to figure good way for swapable abilities 
	return velocityPlayer + velocityEnviroment + velocityAugment


func died() -> void:
	pass

func ledge_detection()-> void:
	#TODO: look into mvoing this to the raycasts
	if is_on_floor() and !ledgeDetectionLeft.is_colliding():
		ledgeLeft = true
	else:
		ledgeLeft = false
	
	if is_on_floor() and !ledgeDetectionRight.is_colliding():
		ledgeRight = true
	else:
		ledgeRight = false

func set_timers() -> void:
	coyoteJumpTimer.wait_time = coyoteTime
	coyoteJumpWallTimer.wait_time = coyoteTime
	bufferJumpTimer.wait_time = jumpBufferTime
	dashTimer.wait_time = dashDuration
	semisolidResetTimer.wait_time = semisolidResetTime
	#TODO: move this over to timers


func attempt_vertical_corner_correction(amount: int, delta) -> void:
	for i in range(1, amount*2+1):
		for j in [-1.0, 1.0]:
			if !test_move(global_transform.translated(Vector2(0, i * j / 2)), Vector2(velocity.x * delta, 0)):
				translate(Vector2(0, i * j / 2))
				if velocity.y * j < 0: velocity.y = 0
				return


func attempt_horizontal_corner_correction(amount: int, delta) -> void:
	for i in range(1, amount*2+1):
		for j in [-1.0, 1.0]:
			if !test_move(global_transform.translated(Vector2(i * j / 2, 0)), Vector2(0, velocity.y * delta)):
				translate(Vector2(i * j / 2, 0))
				if velocity.x * j < 0: velocity.x = 0
				return


func _on_SemisolidReset_timeout() -> void:
	set_collision_mask_bit(Globals.SEMISOLID, true)

func bounce(amount) -> void:
	EventBus.emit_signal("playerBounced", amount)

func change_health(amount: int) -> void:
	EventBus.emit_signal("playerHealthChanged", amount)
