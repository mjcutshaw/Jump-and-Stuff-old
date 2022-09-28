extends Interactable
class_name BounceBox

#TODO: move to new layer
#TODO: setget bounce direction
#TODO: make spring scene
#TODO: only for players atm
#TODO: have bounce speed be min, invert if player is faster
#TODO: spring only activates after jumpjing

export var amount: int = 1000
enum direction {null, up, down, left, right, upLeft, upRight, downLeft, downRight,}
export (direction) var bounceDirection
var bounceVector: Vector2 = Vector2.ZERO

func _ready() -> void:
	connect("body_entered", self, "on_bounceBox_entered")
	bounce_direction()

func bounce_direction() -> void:
	if bounceDirection == direction.up:
		bounceVector = Vector2(0, -amount)
	if bounceDirection == direction.down:
		rotation = deg2rad(180)
		bounceVector = Vector2(0, amount)
	if bounceDirection == direction.left:
		bounceVector = Vector2(-amount, 0)
		rotation = deg2rad(270)
	if bounceDirection == direction.right:
		bounceVector = Vector2(amount, 0)
		rotation = deg2rad(90)
	if bounceDirection == direction.upLeft:
		bounceVector = Vector2(-amount, -amount)
		rotation = deg2rad(315)
	if bounceDirection == direction.upRight:
		bounceVector = Vector2(amount, -amount)
		rotation = deg2rad(45)
	if bounceDirection == direction.downLeft:
		bounceVector = Vector2(-amount, amount)
		rotation = deg2rad(225)
	if bounceDirection == direction.downRight:
		bounceVector = Vector2(amount, amount)
		rotation = deg2rad(135)


func on_bounceBox_entered(body: Player) -> void:
	body.bounce(bounceVector)

