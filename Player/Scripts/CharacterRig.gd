extends Node2D

onready var player: Player = owner
onready var body: Node2D = $Frame
onready var animPlayer: AnimationPlayer = $AnimationPlayer
var lastDirection: int = 1
var facing: int
var spawning: bool = false
export var flipTime: float = .1
export var growTime: float = .3

#TODO: use signals to control animations or make animation tree
#TODO: move out of physics so on called when needed
#TODO: change hit box depending on state, shrink a bit in the air


func _ready() -> void:
	EventBus.connect("jump", self, "jump")
	EventBus.connect("fall", self, "fall")
	EventBus.connect("playerSpawned", self, "spawned")

func _physics_process(delta: float) -> void:
	if !spawning:
		if move_direction() > 0:
			if scale.x == -1:
				var tween = create_tween()
				tween.tween_property(self, "scale", Vector2(1,1), flipTime).from(Vector2(-1,1)) #TODO: Easin, out
			lastDirection = 1
		elif move_direction() < 0:
			if scale.x == 1:
				var tween = create_tween()
				tween.tween_property(self, "scale", Vector2(-1,1), flipTime).from(Vector2(1,1))
			lastDirection = -1
#TODO: turn into global or player
func move_direction() -> int:
	return  - int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))

func jump():
	animPlayer.play("Jump")

func fall():
	animPlayer.play("Fall")

func spawned() -> void:
	spawning = true
	var tween = create_tween()
	#TODO: move to CharacterRig
	tween.tween_property(player.characterRig, "scale", Vector2(1,1), growTime).from(Vector2(0,0))
	## grows the player on spawn ##
	yield(get_tree().create_timer(growTime),"timeout")
	spawning = false
