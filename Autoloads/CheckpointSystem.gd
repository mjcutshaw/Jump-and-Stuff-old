extends Node

#TODO: needs to be saved
#TODO: last safe ground
var currentRespawn: Vector2 = Vector2.ZERO
var startingArea: Vector2 = Vector2.ZERO
var lastSafeGround: Vector2 = Vector2.ZERO
var lastCheckpoint: Vector2 = Vector2.ZERO


func set_respawn(spawn):
	currentRespawn = spawn
