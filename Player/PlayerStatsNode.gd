extends KinematicBody2D
class_name PlayerStatsNode


var Stats: Resource = preload("res://Resources/PlayerStats.tres")


onready var moveSpeed: int = Stats.moveSpeed
onready var acceleration: float = Stats.acceleration
onready var friction: float = Stats.friction

onready var jumpHeightMax: float = Stats.jumpHeightMax
onready var jumpHeightMin: float = Stats.jumpHeightMin
onready var jumpTimeToPeak: float = Stats.jumpTimeToPeak
onready var jumpTimeToDescent: float = Stats.jumpTimeToDescent
onready var jumpTimeAtApex: float = Stats.jumpTimeAtApex
onready var jumpApexHeight: float = Stats.jumpApexHeight
onready var terminalVelocity: int = Stats.terminalVelocity
onready var moveSpeedApex: int = Stats.moveSpeedApex

onready var gravityJump: float = 2 * jumpHeightMax / pow(jumpTimeToPeak, 2)
onready var gravityFall: float = 2 * jumpHeightMax / pow(jumpTimeToDescent, 2)
onready var gravityApex: float = 2 * jumpHeightMax / pow(jumpTimeAtApex, 2)
onready var gravityGlide: float = gravityFall/10
onready var jumpVelocityMax: float = -sqrt(2 * gravityJump * jumpHeightMax)
onready var jumpVelocityMin: float = -sqrt(2 * gravityJump * jumpHeightMin)


func _ready() -> void:
	EventBus.connect("update_stats", self, "update_stats")


func update_stats():
	update()
	## used to reload from stat changes

