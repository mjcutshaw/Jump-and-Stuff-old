extends MarginContainer


onready var healthEmpty: TextureRect = $HealthEmpty
onready var healthFull: TextureRect = $HealthFull

export var textureSize: int ## Size of asset ##


func _ready() -> void:
	#TODO: hidable ui
	show()
	EventBus.connect("healthUI", self, "set_health")
	EventBus.connect("playerHealthMaxChanged", self, "set_health_max")


func set_health(amount:int) -> void:
	if amount != null:
		healthFull.rect_size.x = amount * textureSize


func set_health_max(amount:int) -> void:
	if amount != null:
		healthEmpty.rect_size.x = amount * textureSize
