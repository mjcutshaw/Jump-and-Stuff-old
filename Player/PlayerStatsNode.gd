extends Actors
class_name PlayerStatsNode


var Stats: Resource = preload("res://Resources/PlayerStats.tres")

onready var moveSpeed: int = Stats.moveSpeed * Globals.TILE_SIZE
onready var acceleration: float = Stats.acceleration
onready var friction: float = Stats.friction

onready var jumpHeightMax: float = Stats.jumpHeightMax  * Globals.TILE_SIZE
onready var jumpHeightMin: float = Stats.jumpHeightMin
onready var jumpTimeToPeak: float = Stats.jumpTimeToPeak
onready var jumpTimeToDescent: float = Stats.jumpTimeToDescent
onready var jumpTimeAtApex: float = Stats.jumpTimeAtApex
onready var jumpApexHeight: float = Stats.jumpApexHeight
onready var terminalVelocity: int = Stats.terminalVelocity * Globals.TILE_SIZE
onready var moveSpeedApex: int = Stats.moveSpeedApex * Globals.TILE_SIZE

onready var gravityJump: float = 2 * jumpHeightMax / pow(jumpTimeToPeak, 2)
onready var gravityFall: float = 2 * jumpHeightMax / pow(jumpTimeToDescent, 2)
onready var gravityApex: float = 2 * jumpHeightMax / pow(jumpTimeAtApex, 2)
onready var gravityGlide: float = gravityFall/10
onready var jumpVelocityMax: float = -sqrt(2 * gravityJump * jumpHeightMax)
onready var jumpVelocityMin: float = -sqrt(2 * gravityJump * jumpHeightMin)

onready var dashDistance: int = Stats.dashDistance * Globals.TILE_SIZE

onready var slideSpeed: int = Stats.slideSpeed * Globals.TILE_SIZE
onready var quickSlideSpeed: int = Stats.quickSlideSpeed * Globals.TILE_SIZE


func _ready() -> void:
	EventBus.connect("update_stats", self, "update_stats")
	healthMax = Stats.healthMax
	health = Stats.health


func update_stats():
	update()
	## used to reload from stat changes

