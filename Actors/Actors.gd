extends KinematicBody2D
class_name Actors

var health: int
export var healthMax: int

## Enviroment Effects ##
var inWater: bool = false
var inWind: bool = false
var windVelocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass


func change_health(amount: int) -> void:
	health = clamp(health + amount, 0, healthMax)

func reset_health() -> void:
	health = healthMax

func bounce(amount) -> void:
	pass #to be used for enemies
