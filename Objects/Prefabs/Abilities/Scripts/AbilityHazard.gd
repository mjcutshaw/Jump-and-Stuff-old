extends AbilityBlockBase

#TODO can hurt player after respawn, need invincability timer
onready var detectorCollision: CollisionShape2D = $Area2D/CollisionShape2D
onready var collisionShape: CollisionShape2D = $CollisionShape2D
onready var  abilityDetector: Area2D = $Area2D

var playerInHazard: bool = false
var correctAbility: bool = false
var damageAmount: int = 1

func _ready() -> void:
	detectorCollision.shape = collisionShape.shape
	detectorCollision.shape.extents.x = collisionShape.shape.extents.x
	detectorCollision.shape.extents.y = collisionShape.shape.extents.y
	
	abilityDetector.connect("body_entered", self, "_on_hazard_entered")
	abilityDetector.connect("body_exited", self, "_on_hazard_exited")
	connect("body_entered", self, "_on_player_entered")
	connect("body_exited", self, "_on_player_exited")
	if ability == abiliyList.All:
		abilityDetector.set_collision_mask_bit(CollisionLayers.INTERACTABLE, true)
	elif ability == abiliyList.DashSide:
		abilityDetector.set_collision_mask_bit(CollisionLayers.DashSide, true)
	elif ability == abiliyList.DashUp:
		abilityDetector.set_collision_mask_bit(CollisionLayers.DashUp, true)
	elif ability == abiliyList.DashDown:
		abilityDetector.set_collision_mask_bit(CollisionLayers.DashDown, true)
	elif ability == abiliyList.HookShot:
		abilityDetector.set_collision_mask_bit(CollisionLayers.HookShot, true)
	elif ability == abiliyList.Burrow:
		abilityDetector.set_collision_mask_bit(CollisionLayers.Burrow, true)
	elif ability == abiliyList.SwimDash:
		abilityDetector.set_collision_mask_bit(CollisionLayers.SwimDash, true)
	else:
		if ability != abiliyList.null:
			EventBus.emit_signal("error", "Ability Boost error for " + str(ability) +" at: "  + str(name) + " at " + str(global_position))

func _physics_process(delta: float) -> void:
	if playerInHazard and !correctAbility:
		EventBus.emit_signal("playerHealthChanged", -damageAmount)

func _on_player_entered(body: Player) -> void:
	playerInHazard = true

func _on_player_exited (body: Player) -> void:
	playerInHazard = false

func _on_hazard_entered(body: Player) -> void:
	correctAbility = true

func _on_hazard_exited(body: Player) -> void:
	correctAbility = false
