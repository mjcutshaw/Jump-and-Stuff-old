extends EnviromentalEffects

#LOOKAT: wind to slow player vs gust/airstreams to float on
#TODO: tool script to show in editor
#TODO: extend off directional effects
export var strength: int = 0
export var direction: int

onready var collisionShape: CollisionShape2D = $CollisionShape2D
onready var particles: Particles2D = $Particles2D

func _ready() -> void:
	connect("body_entered", self, "enter_wind")
	connect("body_exited", self, "exit_wind")
	#TODO: add other shapes in
	particles.process_material.emission_box_extents.x = collisionShape.shape.extents.x
	particles.process_material.emission_box_extents.y = collisionShape.shape.extents.y


func enter_wind(body: Actors) -> void:
	body.inWind = true


func exit_wind(body: Actors) -> void:
	body.inWind = false
