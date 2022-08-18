extends Node2D

onready var player: Player = owner
onready var body: Node2D = $Frame
onready var animPlayer: AnimationPlayer = $AnimationPlayer
var lastDirection: int = 1
var facing: int

#TODO: use signals to control animations or make animation tree
#TODO: move out of physics so on called when needed
#TODO: change hit box depending on state, shrink a bit in the air


func _ready() -> void:
	EventBus.connect("jump", self, "jump")
	EventBus.connect("fall", self, "fall")

func _physics_process(delta: float) -> void:
	#TODO: tween the flip
	if player.velocity.x > 0:
		scale.x = 1
		lastDirection = 1
	elif player.velocity.x < 0:
		scale.x = -1
		lastDirection = -1
#	else:
#		body.scale.x = lastDirection
	## probably will cause problems later

func jump():
	animPlayer.play("Jump")

func fall():
	animPlayer.play("Fall")
