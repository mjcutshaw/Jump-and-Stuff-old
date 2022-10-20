extends Node

#TODO: needs to be saved
#TODO: last safe ground
var currentRespawn: Vector2 = Vector2.ZERO
var startingArea: Vector2 = Vector2.ZERO
var lastSafeGround: Vector2 = Vector2.ZERO
var lastCheckpoint: Vector2 = Vector2.ZERO

#TODO: will be teleporting to new scene when adding new areas
enum waypointsName {
	null,
	Up,
	Down
}

var waypointLocation: Vector2
var waypoints: Dictionary = {}

func _ready() -> void:
	EventBus.connect("setRespawn", self, "set_respawn")
	EventBus.connect("addWaypoint", self, "add_waypoint")

func set_respawn(name, location):
	currentRespawn = location

func add_waypoint(name, location) -> void:
	waypoints[name] = location
