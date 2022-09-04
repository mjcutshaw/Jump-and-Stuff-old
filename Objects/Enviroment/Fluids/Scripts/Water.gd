extends Fluids
#TODO: should be a tilemap

export var poison: bool = false
export var boiling: bool = false
export var freezing: bool = false
#TODO: upgrades that work for going into lava/snow let you enter before fixing

func _ready() -> void:
	connect("body_entered", self, "enter_water")
	connect("body_exited", self, "exit_water")


func enter_water(body: Actors) -> void:
	body.inWater = true


func exit_water(body: Actors) -> void:
	body.inWater = false
