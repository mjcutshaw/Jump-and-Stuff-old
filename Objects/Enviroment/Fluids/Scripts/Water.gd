extends Fluids
#TODO: should be a tilemap
#FXIME: shader is being weird
export var poison: bool = false
export var boiling: bool = false
export var freezing: bool = false

onready var bubbles: Particles2D = $Bubbles
#TODO: upgrades that work for going into lava/snow let you enter before fixing

func _ready() -> void:
	connect("body_entered", self, "enter_water")
	connect("body_exited", self, "exit_water")
	
	bubbles.emitting = true
	bubbles.amount = rand_range(5, 15)
	
	if poison:
		modulate = Color.purple
	if boiling:
		modulate = Color.orangered
	if freezing:
		modulate = Color.lightblue
	
	#TODO: handle if more than one is checked


func enter_water(body: Actors) -> void:
	body.inWater = true


func exit_water(body: Actors) -> void:
	body.inWater = false
