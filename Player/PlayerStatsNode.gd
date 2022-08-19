extends Actors
class_name PlayerStatsNode


var Stats: Resource = preload("res://Resources/PlayerStats.tres")


onready var baseMoveSpeed: int = Stats.moveSpeed
var moveSpeed: int
onready var baseAcceleration: float = Stats.acceleration
var acceleration: float
onready var basefriction: float = Stats.friction
var friction: float

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
	EventBus.connect("playerHealthChanged", self, "health_changed")
	
	healthMax = Stats.healthMax
	health = Stats.health
	
	yield(get_tree(), "idle_frame") #needs to wait so it updates
	EventBus.emit_signal("healthUI", health)
	EventBus.emit_signal("playerHealthMaxChanged", healthMax)


func update_stats():
	healthMax = Stats.healthMax
	health = Stats.health
	
	moveSpeed = baseMoveSpeed * Globals.TILE_SIZE
	acceleration = baseAcceleration * Globals.TILE_SIZE
	friction = basefriction * Globals.TILE_SIZE
	
	jumpHeightMax = baseJumpHeightMax * Globals.TILE_SIZE
	gravityJump = 2 * jumpHeightMax / pow(jumpTimeToPeak, 2)
	gravityFall = 2 * jumpHeightMax / pow(jumpTimeToDescent, 2)
	jumpVelocityMax = -sqrt(2 * gravityJump * jumpHeightMax)
	jumpVelocityMin = -sqrt(2 * gravityJump * jumpHeightMin)



func change_stat(stat: int, amount: int):
	if stat == Globals.statList.MoveSpeed:
		baseMoveSpeed += amount
	elif stat == Globals.statList.JumpHeight:
		baseJumpHeightMax += amount
	elif stat == Globals.statList.HealthMax:
		healthMax += amount
		health = healthMax
		EventBus.emit_signal("healthUI", health)
	else:
		EventBus.emit_signal("error", str("invalid stat change = " + str(stat)))
	
	update_stats()


func health_changed(amount) -> void:
	health = clamp(health + amount, 0, healthMax)
	EventBus.emit_signal("healthUI", health)
	
	if health == 0:
		EventBus.emit_signal("playerDied")
