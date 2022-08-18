extends Node2D

onready var player: Player = owner
onready var body: Node2D = $Frame
onready var animPlayer: AnimationPlayer = $AnimationPlayer
var lastDirection: int = 1
var facing: int
export var flipTime: float = .1

#TODO: use signals to control animations or make animation tree
#TODO: move out of physics so on called when needed
#TODO: change hit box depending on state, shrink a bit in the air


func _ready() -> void:
	EventBus.connect("jump", self, "jump")
	EventBus.connect("fall", self, "fall")

func _physics_process(delta: float) -> void:
	if player.velocity.x > 0:
		if scale.x == -1:
			var tween = create_tween()
			tween.tween_property(self, "scale", Vector2(1,1), flipTime).from(Vector2(-1,1))
		lastDirection = 1
	elif player.velocity.x < 0:
		if scale.x == 1:
			var tween = create_tween()
			tween.tween_property(self, "scale", Vector2(-1,1), flipTime).from(Vector2(1,1))
		lastDirection = -1


func jump():
	animPlayer.play("Jump")

func fall():
	animPlayer.play("Fall")
