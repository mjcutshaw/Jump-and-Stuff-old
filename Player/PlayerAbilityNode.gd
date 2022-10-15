extends PlayerStatsNode
class_name PlayerAbilitiesNode

#LOOKAT: get rid of resource?
#TODO: ability modifiers like melting/cooling to open areas
var Abilities: Resource = preload("res://Resources/PlayerAbilities.tres")

onready var abilities: Node = $Abilities
onready var augments: Node = $Augments

onready var unlockedJump: bool = Abilities.unlockedJump
onready var unlockedJumpAir: bool = Abilities.unlockedJumpAir
onready var unlockedJumpCrouch: bool = Abilities.unlockedJumpCrouch
onready var unlockedJumpLong: bool = Abilities.unlockedJumpLong
onready var unlockedJumpWall: bool = Abilities.unlockedJumpWall
onready var unlockedJumpWallLeft: bool = Abilities.unlockedJumpWallLeft
onready var unlockedJumpWallRight: bool = Abilities.unlockedJumpWallRight
onready var unlockedDash: bool = Abilities.unlockedDash
onready var unlockedDashAir: bool = Abilities.unlockedDashAir
onready var unlockedDashLeft: bool = Abilities.unlockedDashLeft
onready var unlockedDashRight: bool = Abilities.unlockedDashRight
onready var unlockedDashWall: bool = Abilities.unlockedDashWall
onready var unlockedGlide: bool = Abilities.unlockedGlide
onready var unlockedGroundPound: bool = Abilities.unlockedGroundPound
onready var unlockedHookShot: bool = Abilities.unlockedHookShot
onready var unlockedClimb: bool = Abilities.unlockedClimb
onready var unlockedClimbLeft: bool = Abilities.unlockedClimbLeft
onready var unlockedClimbRight: bool = Abilities.unlockedClimbRight

onready var maxJump: int = Abilities.maxJump
onready var maxJumpAir: int = Abilities.maxJumpAir
onready var maxDash: int = Abilities.maxDash

onready var dashCDTimer: Timer = $Timers/DashCD

var remainingJumpAir: int = 1
var remainingDash: int = 1

var targetHookShot: Area2D = null
var targetBurrow: Area2D = null
#FIXEME: if a target is at zero it won't work


func _ready() -> void:
	EventBus.connect("update_abilities", self, "update_abilities")
	EventBus.connect("playerAugmentUnlocked", self, "augment_unlocked")
	EventBus.connect("playerAbilityUnlocked", self, "ability_unlocked")
	
	for child in abilities.get_children():
		child.initialize(self)
	for child in augments.get_children():
		child.initialize(self)

func update_abilities():
	update()
	## used to reload from ability changes


func unlock_ability(ability: int) -> void:
	if ability == Abilities.abiliyList.All:
		unlockedJumpAir = true
		unlockedDash = true
	elif ability == Abilities.abiliyList.JumpAir:
		if unlockedJumpAir:
			maxJumpAir = +1
		else:
			unlockedJumpAir = true
	elif ability == Abilities.abiliyList.Dash:
		#TODO: logic for increased dashes
		if unlockedDash:
			maxDash += 1
		else:
			unlockedDash = true
	else:
		EventBus.emit_signal("error", "Null Ability Unlocked")
	EventBus.emit_signal("ability_check")
	#TODO: using this?


func ability_unlocked(ability: Ability) -> void:
	abilities.add_child(ability)
	for i in abilities.get_children():
		i.initialize(self)

func augment_unlocked(augment: Augment) -> void:
	augments.add_child(augment)
	for i in augments.get_children():
		i.initialize(self)

#LOOKAT: can to ability first?
func can_use_ability(ability: int) -> bool:
	#TODO: add back in unlock check
	if ability == Globals.abiliyList.Dash and remainingDash > 0 and dashCDTimer.is_stopped():
		return true
	elif ability == Globals.abiliyList.JumpAir and remainingJumpAir > 0:
		return true
	return false
#	if ability == Globals.abiliyList.Dash and remainingDash > 0 and unlockedDash:
#		return true
#	elif ability == Globals.abiliyList.JumpAir and remainingJumpAir > 0 and unlockedJumpAir:
#		return true
#	return false

func consume_ability(ability: int, amount: int) -> void:
	#TODO: Use 99 remove all or all a third input to do that
	if ability == Globals.abiliyList.All:
		set_jump_air(-amount)
		set_dash(-amount)
	elif ability == Globals.abiliyList.JumpAir:
		set_jump_air(-amount)
	elif ability == Globals.abiliyList.Dash:
		set_dash(-amount)
	else:
		print("Null Ability Consume")
	EventBus.emit_signal("ability_check")


func reset_ability(ability: int) -> void:
	if ability == Globals.abiliyList.All:
		set_dash(maxDash)
		set_jump_air(maxJumpAir)
	elif ability == Globals.abiliyList.JumpAir:
		set_jump_air(maxJumpAir)
	elif ability == Globals.abiliyList.Dash:
		set_dash(maxDash)
	else:
		print("Null Ability Reset")
	EventBus.emit_signal("ability_check")


func set_jump_air(amount: int) -> void:
	remainingJumpAir = clamp(remainingJumpAir + amount, 0, maxJumpAir)


func set_dash(amount: int) -> void:
	remainingDash = clamp(remainingDash + amount, 0, maxDash)
