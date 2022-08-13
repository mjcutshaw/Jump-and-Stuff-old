extends KinematicBody2D
class_name Actors

var health: int
export var healthMax: int

func _ready() -> void:
	pass


func change_health(amount: int):
	health = clamp(health + amount, 0, healthMax)
	print(str(self) + str(" takes damage"))

func reset_health():
	health = healthMax
