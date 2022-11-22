extends MarginContainer

#TODO: ability unlocked. have max jump count announced (double,triple, etc)

onready var announceLabel: Label = $MarginContainer/Announce
onready var announceTimer: Timer = $Timer
export var annoucmentLength: float = 2.0

var queue: Array = []
signal announcementFinished

func _ready() -> void:
	announceTimer.wait_time = annoucmentLength
	hide()
	EventBus.connect("playerStatChange", self, "announce_stat_change")
	EventBus.connect("playerAbilityUnlocked", self, "announce_ability_unlocked")
	announceTimer.connect("timeout", self, "announce_finished")
	connect("announcementFinished", self, "check_announcement_que")

func announce(announcment: String) -> void:
	if announceTimer.is_stopped():
		show()
		announceLabel.text = announcment
		announceTimer.start()
	else:
		store_announce(announcment)

func store_announce(announcment: String) -> void:
	queue.append(announcment)

func announce_finished() -> void:
	announceLabel.text = ""
	hide()
	emit_signal("announcementFinished")

func check_announcement_que() -> void:
	if not queue.empty():
		var nextAnnouncement = queue.pop_front()
		announce(nextAnnouncement)

func announce_stat_change(stat: int, amount: int) -> void:
	if stat == Globals.statList.MoveSpeed:
		announce(str("Move speed inscreased by ", amount))
	elif stat == Globals.statList.JumpHeight:
		announce(str("Jump height inscreased by ", amount))
	elif stat == Globals.statList.HealthMax:
		announce(str("Max health inscreased by ", amount))
	else:
		EventBus.emit_signal("error", str("stat change error: ", stat))
	

func announce_ability_unlocked(ability: int) -> void:
	if ability == Globals.abiliyList.All:
		announce(str("The whole enchilanda unlocked"))
	elif ability == Globals.abiliyList.DashGround:
		announce(str("Dash Unlocked"))
	elif ability == Globals.abiliyList.JumpAir:
		announce(str("Double Jump Unlocked "))
	else:
		EventBus.emit_signal("error", str("ability unlock error: ", ability))
