extends BaseMenu

#FIXME: check if waypoint location is null. crash

onready var waypointUpButton: Button = $"%Up"
onready var waypointDownButton: Button = $"%Down"
var teleportPlayer: bool = false
var teleportLocation: int

#TODO: need resource file to contain names

func _ready() -> void:
	waypointUpButton.connect("pressed", self, "waypoint_up_pressed")
	waypointDownButton.connect("pressed", self, "waypoint_down_pressed")

func enter() -> void:
	set_paused(true)
	visible = true
	waypointUpButton.grab_focus()


func exit() -> void:
	set_paused(false)
	if teleportPlayer:
		EventBus.emit_signal("teleportPlayerToWaypoint", teleportLocation)
	teleportLocation = CheckpointSystem.waypointsName.null
	teleportPlayer = false
	visible = false


func handle_input(event: InputEvent) -> BaseMenu:
	if Input.is_action_just_pressed("ui_pause") or Input.is_action_just_pressed("fast_travel"):
		return State.Unpaused
	
	return State.Null

func state_check() -> BaseMenu:
	if teleportPlayer:
		return State.Unpaused
	
	return State.Null

func waypoint_up_pressed() -> void:
	teleportLocation =  CheckpointSystem.waypointsName.Up
	teleportPlayer = true

func waypoint_down_pressed() -> void:
	teleportLocation =  CheckpointSystem.waypointsName.Down
	teleportPlayer = true
