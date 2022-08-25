extends MarginContainer

onready var stateLabel: Label = $MarginContainer/VBoxContainer/State
onready var velocityLabel: Label = $MarginContainer/VBoxContainer/Velocity
onready var debug1Label: Label = $MarginContainer/VBoxContainer/Debug1
onready var debug2Label: Label = $MarginContainer/VBoxContainer/Debug2
onready var debug3Label: Label = $MarginContainer/VBoxContainer/Debug3


func _ready() -> void:
	EventBus.connect("debugState", self, "state_label")
	EventBus.connect("debugVelocity", self, "velocity_label")
	EventBus.connect("debug1", self, "debug_1_label")
	EventBus.connect("debug2", self, "debug_2_label")
	EventBus.connect("debug3", self, "debug_3_label")


func state_label(info) -> void:
	stateLabel.text = str(info)

func velocity_label(info) -> void:
	velocityLabel.text = str(info)

func debug_1_label(type, info) -> void:
	debug1Label.text = str(type, ": ", info)

func debug_2_label(type, info) -> void:
	debug2Label.text = str(type, ": ", info)

func debug_3_label(type, info) -> void:
	debug3Label.text = str(type, ": ", info)
