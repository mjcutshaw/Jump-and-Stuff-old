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

