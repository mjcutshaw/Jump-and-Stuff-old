extends Node2D

onready var player: Player = owner
onready var body: Node2D = $Sprite
var lastDirection: int = 1
var facing: int

#TODO: use signals to control animations or make animation tree
#TODO: move out of physics so on called when needed
#TODO: change hit box depending on state, shrink a bit in the air

func _physics_process(delta: float) -> void:
	if player.velocity.x > 0:
		scale.x = 1
		lastDirection = 1
	elif player.velocity.x < 0:
		scale.x = -1
		lastDirection = -1
#	else:
#		body.scale.x = lastDirection
	## probably will cause problems later
