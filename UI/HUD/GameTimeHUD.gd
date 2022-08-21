extends Control
#TODO: move into stats
var timePlayed: float
var strTimeElapsed: String

onready var playTimeLabel: Label = $MarginContainer/PlayTime

func _ready() -> void:
	show()

func _process(delta) -> void:
	timePlayed += delta
	var mils = fmod(timePlayed,1)*1000
	var secs = fmod(timePlayed,60)
	var mins = fmod(timePlayed, 3600) / 60
	var hr = fmod(timePlayed,3600 * 60) / 3600
	strTimeElapsed = "%02d : %02d : %02d . %03d" % [hr, mins, secs, mils]
	
	playTimeLabel.text = strTimeElapsed
