extends Control

#TODO: use line2d to move between highlighted buttons
#TODO: grab focus
onready var gameNameLabel: Label = $"%GameName"
onready var gameVersionLabel: Label = $"%GameVersion"
onready var engineVersionLabel: Label = $"%EngineVersion"
onready var creatorLabel: Label = $"%Creator"

func _ready():
	gameNameLabel.text = GameInfo.TITLE
	gameVersionLabel.text = GameInfo.VERSION
	engineVersionLabel.text =  "Godot %s" % Engine.get_version_info().string
	creatorLabel.text = GameInfo.CREATOR
