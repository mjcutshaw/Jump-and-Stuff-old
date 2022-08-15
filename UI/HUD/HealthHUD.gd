extends MarginContainer

#TODO: move over to player script
var Stats: Resource = preload("res://Resources/PlayerStats.tres")

onready var healthEmpty: TextureRect = $HealthEmpty
onready var healthFull: TextureRect = $HealthFull

export var textureSize: int ## Size of asset ##


func _ready() -> void:
	#TODO: hide ui
	show()
	EventBus.connect("healthUI", self, "set_health")
	EventBus.connect("playerHealthMaxChanged", self, "set_health_max")
	
	yield(get_tree(), "idle_frame") #needs to wait so it updatess
	set_health(Stats.health)
	set_health_max(Stats.healthMax)



func set_health(amount:int) -> void:
	if amount != null:
		healthFull.rect_size.x = amount * textureSize

func set_health_max(amount:int) -> void:
	if amount != null:
		healthEmpty.rect_size.x = amount * textureSize
