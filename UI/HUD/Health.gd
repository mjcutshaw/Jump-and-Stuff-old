extends Control

#TODO: move over to player script
var Stats: Resource = preload("res://Resources/PlayerStats.tres")

onready var healthEmpty: TextureRect = $HealthEmpty
onready var healthFull: TextureRect = $HealthFull

export var textureSize: int ## Size of asset ##

var health: int setget set_health
var healthMax: int setget set_health_max


func _ready() -> void:
	show()
	healthMax = Stats.healthMax
	health = Stats.health
	
	EventBus.connect("playerHealthChanged", self, "set_health")
	EventBus.connect("playerHealthMaxChanged", self, "set_health_max")


func set_health(amount:int) -> void:
	health = clamp(health + amount, 0, healthMax)
	if health != null or health == 0:
		if !healthFull.visible:
			healthFull.visible = true
		healthFull.rect_size.x = health * textureSize
	
	if health == 0:
		EventBus.emit_signal("playerDied")

func set_health_max(amount:int) -> void:
	healthMax = max(amount, 1)
	health = min(health, healthMax)
	if healthMax != null:
		healthEmpty.rect_size.x = healthMax * textureSize
