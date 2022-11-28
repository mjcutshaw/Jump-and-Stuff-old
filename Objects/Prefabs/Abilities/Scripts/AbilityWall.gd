extends AbilityBlockBase

onready var staticBodyCollision: CollisionShape2D = $StaticBody2D/CollisionShape2D
onready var collisionShape: CollisionShape2D = $CollisionShape2D
onready var  staticBody: StaticBody2D = $StaticBody2D

func _ready() -> void:
	staticBodyCollision.shape = collisionShape.shape
	staticBodyCollision.shape.extents.x = collisionShape.shape.extents.x
	staticBodyCollision.shape.extents.y = collisionShape.shape.extents.y
	
	if ability == abiliyList.DashSide:
		staticBody.set_collision_layer_bit(CollisionLayers.DashSide, true)
	elif ability == abiliyList.DashUp:
		staticBody.set_collision_layer_bit(CollisionLayers.DashUp, true)
	elif ability == abiliyList.DashDown:
		staticBody.set_collision_layer_bit(CollisionLayers.DashDown, true)
	elif ability == abiliyList.HookShot:
		staticBody.set_collision_layer_bit(CollisionLayers.HookShot, true)
	elif ability == abiliyList.Burrow:
		staticBody.set_collision_layer_bit(CollisionLayers.Burrow, true)
	elif ability == abiliyList.SwimDash:
		staticBody.set_collision_layer_bit(CollisionLayers.SwimDash, true)
	else:
		if ability != abiliyList.null:
			EventBus.emit_signal("error", "Ability Wall error for " + str(ability) +" at: "  + str(name) + " at " + str(global_position))
