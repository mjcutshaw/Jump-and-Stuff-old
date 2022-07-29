extends Node2D

onready var player: Player = owner
onready var body: Node2D = $Body
var lastDirection: int = 1
var facing: int

#TODO: make generic for reuse
#TODO: move out of physics so on called when needed

func _physics_process(delta: float) -> void:
	if player.velocity.x > 0:
		body.scale.x = 1
		lastDirection = 1
	elif player.velocity.x < 0:
		body.scale.x = -1
		lastDirection = -1
#	else:
#		body.scale.x = lastDirection
	## probably will cause problems later
