extends Augment

#FIXME: only works once. looks like speed get stuck at 318

## SMW like p speed ##

#onready var player: Player = owner

#var startingSpeed: int = player.moveSpeed
var pTime
export var pTimeAmount: int = 1



func _ready() -> void:
	pTime = pTimeAmount

func _physics_process(delta: float) -> void:
	if player.is_on_floor():
		logic(delta)

func logic(delta) -> void:
	EventBus.emit_signal("error", str(pTime))
	pTime = clamp(pTime, 0 , pTimeAmount)
	
	if player.moveSpeed > abs(player.velocityPlayer.x):
		pTime += delta
	if abs(player.velocityPlayer.x) >= player.moveSpeed:
		pTime -= delta


#TODO: logic to tell player to use
#TODO: keep track when active
#FIXMe: this works, but will kill other augments
#TODO: makes functions to add and subtract is added velocity
	if pTime <= 0 and abs(player.velocityPlayer.x) >= player.moveSpeed:
		player.velocityAugment.x = player.moveSpeed * 2 #TODO: lerp() and var
	if pTime > 0:
		player.velocityAugment.x = 0
