extends Actors
class_name PlayerStatsNode

#LOOKAT: get rid of resource?
var Stats: Resource = preload("res://Resources/PlayerStats.tres")


onready var baseMoveSpeed: int = Stats.moveSpeed
onready var baseAccelerationGround: float = Stats.accelerationGround
onready var basefrictionGround: float = Stats.frictionGround
onready var basefrictionSkid: float = Stats.frictionSkid

var moveSpeed: int
var accelerationGround: float
var frictionGround: float
#TODO: accel skid?
var frictionSkid: float

onready var baseJumpHeightMax: float = Stats.jumpHeightMax
onready var jumpHeightMin: float = Stats.jumpHeightMin
onready var jumpHeightApex: float = Stats.jumpHeightApex
onready var jumpTimeToPeak: float = Stats.jumpTimeToPeak
onready var jumpTimeToDescent: float = Stats.jumpTimeToDescent
onready var jumpTimeAtApex: float = Stats.jumpTimeAtApex
onready var baseAccelerationAir: float = Stats.accelerationAir
onready var basefrictionAir: float = Stats.frictionAir
onready var baseTerminalVelocity: float = Stats.terminalVelocity
onready var glideFallSpeedModifier: int = Stats.glideFallSpeedModifier #TODO: look into
onready var glideSpeedModifier: int = Stats.glideSpeedModifier #TODO: look into
var jumpHeightMax: float
var gravityJump: float
var gravityFall: float
var gravityApex: float
var gravityGlide: float
var jumpVelocityMax: float
var jumpVelocityMin: float
var accelerationAir: float
var frictionAir: float
var terminalVelocity: float

var dashVelocity: float
onready var dashDuration: float = Stats.dashDuration

var wallSlideSpeed
var wallQuickSlideSpeed

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
	
	moveSpeed = by_tile_size(baseMoveSpeed)
	accelerationGround = by_tile_size(baseAccelerationGround)
	frictionGround = by_tile_size(basefrictionGround)
	frictionSkid = by_tile_size(basefrictionSkid)
	
	jumpHeightMax = by_tile_size(baseJumpHeightMax)
	gravityJump = 2 * jumpHeightMax / pow(jumpTimeToPeak, 2)
	gravityFall = 2 * jumpHeightMax / pow(jumpTimeToDescent, 2)
	gravityApex = 2 * jumpHeightMax / pow(jumpTimeAtApex, 2)
	gravityGlide = gravityFall/Stats.glideGravityModifier #TODO: look into better equation
	jumpVelocityMax = -sqrt(2 * gravityJump * jumpHeightMax)
	jumpVelocityMin = -sqrt(2 * gravityJump * jumpHeightMin)
	accelerationAir = by_tile_size(baseAccelerationAir)
	frictionAir = by_tile_size(basefrictionAir)
	terminalVelocity = by_tile_size(baseTerminalVelocity)
	
	dashVelocity = by_tile_size(Stats.dashDistance)/Stats.dashDuration
	
	wallSlideSpeed = by_tile_size(Stats.wallSlideSpeed)
	wallQuickSlideSpeed = by_tile_size(Stats.wallQuickSlideSpeed)


func by_tile_size(amount) -> float:
	return amount * Globals.TILE_SIZE

func change_stat(stat: int, amount: int):
	#TODO: should this update the base sheet?
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
