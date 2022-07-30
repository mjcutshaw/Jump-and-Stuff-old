extends Node

#TODO: make augment class

## SMW like p speed ##

onready var player: Player = owner

#var startingSpeed: int = player.moveSpeed
var pTime
export var pTimeAmount: int = 1



func _ready() -> void:
	pTime = pTimeAmount

func _physics_process(delta: float) -> void:
	pass
#	if owner.is_on_floor():
#		logic(delta)

func logic(delta) -> void:
	pTime = clamp(pTime, 0 , pTimeAmount)
	
	if player.moveSpeed > abs(player.velocityPlayer.x):
		pTime += delta
	elif player.moveSpeed == abs(player.velocityPlayer.x):
		pTime -= delta


#TODO: logic to tell player to use
#TODO: keep track when active

#if pTime == 0 and (player.velocityPlayer.x >= player.moveSpeed):
##		player.velocityPlayer.x = player.moveSpeed * 1.2 #TODO: lerp() and var
