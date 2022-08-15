extends Actors
class_name PlayerStatsNode


var Stats: Resource = preload("res://Resources/PlayerStats.tres")


onready var baseMoveSpeed: int = Stats.moveSpeed
var moveSpeed: int
onready var acceleration: float = Stats.acceleration
onready var friction: float = Stats.friction

onready var baseJumpHeightMax: float = Stats.jumpHeightMax
var jumpHeightMax: float
onready var jumpHeightMin: float = Stats.jumpHeightMin
onready var jumpTimeToPeak: float = Stats.jumpTimeToPeak
onready var jumpTimeToDescent: float = Stats.jumpTimeToDescent


var gravityJump: float
var gravityFall: float
var jumpVelocityMax: float
var jumpVelocityMin: float


func _ready() -> void:
	update_stats()
	EventBus.connect("update_stats", self, "update_stats")
	EventBus.connect("playerStatChange", self, "change_stat")


func update_stats():
	healthMax = Stats.healthMax
	health = Stats.health
	
	moveSpeed = baseMoveSpeed * Globals.TILE_SIZE
	
	jumpHeightMax = baseJumpHeightMax * Globals.TILE_SIZE
	gravityJump = 2 * jumpHeightMax / pow(jumpTimeToPeak, 2)
	gravityFall = 2 * jumpHeightMax / pow(jumpTimeToDescent, 2)
	jumpVelocityMax = -sqrt(2 * gravityJump * jumpHeightMax)
	jumpVelocityMin = -sqrt(2 * gravityJump * jumpHeightMin)


func change_stat(stat: int, amount: int):
	if stat == 0:
		baseMoveSpeed += amount
	elif stat == 1:
		baseJumpHeightMax += amount
	elif stat == 2:
		healthMax += amount
		health = healthMax
		EventBus.emit_signal("healthUI", health)
	else:
		print("invalid stat change = " + str(stat))
	
	update_stats()

