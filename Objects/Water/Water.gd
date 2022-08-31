extends Area2D

#TODO: should be a tilemap

func _ready() -> void:
	connect("body_entered", self, "enter_water")
	connect("body_exited", self, "exit_water")


func enter_water(body: Actors) -> void:
	body.inWater = true


func exit_water(body: Actors) -> void:
	body.inWater = false
