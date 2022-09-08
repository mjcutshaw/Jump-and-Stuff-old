extends Node2D

onready var player: Player = owner
onready var body: Node2D = $Frame
var spawning: bool = false
var dashing: bool = false
export var flipTime: float = .4
export var growTime: float = .5

#TODO: use signals to control animations or make animation tree
#TODO: move out of physics so on called when needed
#TODO: change hit box depending on state, shrink a bit in the air
#TODO: skidding should shrink player
#
#
#func _ready() -> void:
#	EventBus.connect("playerJumped", self, "jump")
#	EventBus.connect("fall", self, "fall")
#	EventBus.connect("playerSpawned", self, "spawned")
#	EventBus.connect("playerDashed", self, "dash")
#	EventBus.connect("playerGlide", self, "glide")
#	EventBus.connect("playerSuperJumped", self, "super_jump")
#
#func _physics_process(delta: float) -> void:
#
#	if !spawning or !dashing:
#		if player.moveDirection.x > 0:
#			if scale.x == -1:
#				var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
#				tween.tween_property(self, "scale", Vector2(1,1), flipTime).from(Vector2(-1,1))
#			player.facing = 1
#		elif player.moveDirection.x < 0:
#			if scale.x == 1:
#				var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
#				tween.tween_property(self, "scale", Vector2(-1,1), flipTime).from(Vector2(1,1))
#			player.facing = -1
#
#
#func jump():
#	animPlayer.play("Jump")
#
#func super_jump():
#	animPlayer.play("Dash Up")
#
#func fall():
#	animPlayer.play("Fall")
#
#func dash():
#	animPlayer.play("Dash Side")
#	dashing = true
#	yield(get_tree().create_timer(player.dashDuration),"timeout")
#	dashing = false
#
#func glide():
#	animPlayer.play("Glide")
#
#func spawned() -> void:
#	spawning = true
#	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
#	tween.tween_property(player.characterRig, "scale", Vector2(1,1), growTime).from(Vector2(0,0))
#	## grows the player on spawn ##
#	yield(get_tree().create_timer(growTime),"timeout")
#	spawning = false
