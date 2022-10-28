extends Interactable
class_name BounceBox

#TODO: move to new layer
#TODO: setget bounce direction
#TODO: make spring scene
#TODO: only for players atm
#TODO: have bounce speed be min, invert if player is faster
#TODO: spring only activates after jumping

export var strength: int = 1000
var bounceVelocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	bounceVelocity =  Vector2(0,-strength).rotated(rotation)
	connect("body_entered", self, "on_bounceBox_entered")



func on_bounceBox_entered(body: Player) -> void:
	body.bounce(bounceVelocity)

