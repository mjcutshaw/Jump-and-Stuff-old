extends EnviromentalEffects

#LOOKAT: wind to slow player vs gust/airstreams to float on
#TODO: tool script to show in editor
#TODO: extend off directional effects

onready var collisionShape: CollisionShape2D = $CollisionShape2D
onready var particles: Particles2D = $Particles2D
var windVelocity: Vector2

func _ready() -> void:
	connect("body_entered", self, "enter_wind")
	connect("body_exited", self, "exit_wind")
	
	if direction == directions.null:
		EventBus.emit_signal("error", str("wind direction null: " + str(global_position)))
	#TODO: add other shapes in
	adjust_particle()
	
	windVelocity =  Vector2(0,-strength).rotated(rotation)

func adjust_particle():
	particles.process_material.emission_box_extents.x = collisionShape.shape.extents.x
#	particles.lifetime = 
#	particles.amount = 
#	particles.process_material.scale =
#	particles.process_material.initial_velocity =
#TODO: scaling various parts based on size
	
#	particles.process_material.scale = 1/SCALE
#	particles.process_material.initial_velocity = strength * SPEED
#	particles.amount = ceil(scale.x * scale.y * SCALE) + 8
	pass

func enter_wind(body: Actors) -> void:
	body.inWind = true
	body.windVelocity = windVelocity


func exit_wind(body: Actors) -> void:
	body.inWind = false
	body.windVelocity = Vector2.ZERO
