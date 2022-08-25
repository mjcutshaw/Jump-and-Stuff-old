extends Node2D

onready var raycastRight: RayCast2D = $RayCast2D
onready var raycastLeft: RayCast2D = $RayCast2D2
#TODO: change shadpw to draw 
onready var shadow: Sprite = $Sprite

var castLength: int = 800
var collide1: int
var collide2: int
var collide3: int

func _ready() -> void:
	show()
	raycastLeft.cast_to.y = castLength
	raycastRight.cast_to.y = castLength


func _process(_delta: float) -> void:
	#TODO: make not run all the time
	shadow.scale.x = lerp(.5, shadow.position.y, .002)
	shadow.scale.y = lerp(.05, shadow.position.y, .0005 )
	
	if raycastRight.is_colliding() or raycastLeft.is_colliding():
		shadow.visible = true
		collide1 = raycastRight.get_collision_point().y
		collide2 = raycastLeft.get_collision_point().y
		collide3 = min(collide1, collide2)
		if !raycastRight.is_colliding():
			shadow.global_position.y = collide2
		if !raycastLeft.is_colliding():
			shadow.global_position.y = collide1
		else:
			shadow.global_position.y = collide3
	else:
		shadow.visible = false
