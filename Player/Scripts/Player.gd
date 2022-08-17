extends PlayerAbilitiesNode
class_name Player


onready var sm: Node = $StateMachine
onready var characterRig: Node2D = $CharacterRig
onready var stateLabel: Label = $StateLabel
onready var animPlayer: AnimationPlayer = $CharacterRig/AnimationPlayer
onready var abilities: Node = $Abilities
onready var augments: Node = $Augments

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
	EventBus.connect("playerHealthChanged", self, "health_changed")
	EventBus.connect("playerDied", self, "died")
	EventBus.connect("playerAugmentUnlocked", self, "augment_unlocked")
	EventBus.connect("playerAbilityUnlocked", self, "ability_unlocked")
	
	for i in abilities.get_children():
		i.initialize(self)
	for i in augments.get_children():
		i.initialize(self)


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


func health_changed(amount) -> void:
	health = clamp(health + amount, 0, healthMax)
	EventBus.emit_signal("healthUI", health)
	
	if health == 0:
		EventBus.emit_signal("playerDied")


func died() -> void:
	pass

func ability_unlocked(ability: Ability) -> void:
	abilities.add_child(ability)
	for i in abilities.get_children():
		i.initialize(self)

func augment_unlocked(augment: Augment) -> void:
	augments.add_child(augment)
	for i in augments.get_children():
		i.initialize(self)
