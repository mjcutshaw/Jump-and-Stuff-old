extends Interactable
class_name Checkpoint

#TODO: split waypoint and checkpoint

onready var animPlayer: AnimationPlayer = $AnimationPlayer
export var locationName: String
export (CheckpointSystem.waypointsName) var waypointName
export var isWaypoint: bool = false

func _ready() -> void:
	connect("body_entered", self, "_on_Checkpoint_entered")
	animPlayer.play("Unused")
	EventBus.connect("checkpoint", self, "check_if_current_checkpoint")
	
	if isWaypoint:
		if waypointName != null:
			add_waypoint()
		else:
			EventBus.emit_signal("error", "Waypoint without name at: " + str(global_position))

func _on_Checkpoint_entered(body: Player) -> void:
	EventBus.emit_signal("setRespawn", locationName, global_position)
	animPlayer.play("Used")
	EventBus.emit_signal("checkpoint")
	EventBus.emit_signal("playerHealFull") #TODO: adjust with difficulty


func check_if_current_checkpoint():
	if CheckpointSystem.currentRespawn != global_position:
		animPlayer.play("Unused")


func add_waypoint() -> void:
	EventBus.emit_signal("addWaypoint", waypointName, global_position)
