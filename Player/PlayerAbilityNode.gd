extends PlayerStatsNode
class_name PlayerAbilitiesNode

#LOOKAT: get rid of resource?
#TODO: ability modifiers like melting/cooling to open areas
var Abilities: Resource = preload("res://Resources/PlayerAbilities.tres")

#onready var abilities: Node = $Abilities
onready var augments: Node = $Augments

onready var unlockedJumpAir: bool = Abilities.unlockedJumpAir
onready var unlockedJumpWall: bool = Abilities.unlockedJumpWall
onready var unlockedDash: bool = Abilities.unlockedDash
onready var unlockedDashAir: bool = Abilities.unlockedDashAir
onready var unlockedDashUp: bool = Abilities.unlockedDashUp
onready var unlockedDashDown: bool = Abilities.unlockedDashDown
onready var unlockedDashWall: bool = Abilities.unlockedDashWall
onready var unlockedDashJump: bool = Abilities.unlockedDashJump
onready var unlockedDashClimb: bool = Abilities.unlockedDashClimb
onready var unlockedGlide: bool = Abilities.unlockedGlide
onready var unlockedHookShot: bool = Abilities.unlockedHookShot
onready var unlockedClimb: bool = Abilities.unlockedClimb
onready var unlockedGrab: bool = Abilities.unlockedGrab
onready var unlockedSwim: bool = Abilities.unlockedSwim
onready var unlockedSwimDash: bool = Abilities.unlockedSwimDash
onready var unlockedBurrow: bool = Abilities.unlockedBurrow


onready var maxJump: int = Abilities.maxJump
onready var maxJumpAir: int = Abilities.maxJumpAir
onready var maxDash: int = Abilities.maxDash

onready var dashCDTimer: Timer = $Timers/DashCD

var remainingJumpAir: int = 0
var remainingDashAir: int = 1
var remainingDashUp: int = 1
var remainingDashDown: int = 1


var targetHookShot: Area2D = null
var targetBurrow: Area2D = null
#FIXEME: if a target is at zero it won't work


func _ready() -> void:
	EventBus.connect("updateAbilities", self, "update_abilities")
	EventBus.connect("playerAugmentUnlocked", self, "augment_unlocked")
	EventBus.connect("playerAbilityUnlocked", self, "unlock_ability")
	
#	for child in abilities.get_children():
#		child.initialize(self)
	for child in augments.get_children():
		child.initialize(self)

func update_abilities():
	update()
	## used to reload from ability changes


func unlock_ability(ability: int) -> void:
	
	if ability == Globals.abiliyList.All:
		unlockedJumpAir = true
		unlockedDash = true
	elif ability == Globals.abiliyList.JumpAir:
		if unlockedJumpAir:
			maxJumpAir = +1
		else:
			unlockedJumpAir = true
	elif ability == Globals.abiliyList.JumpWall:
		unlockedJumpWall = true
	elif ability == Globals.abiliyList.Dash:
		unlockedDash = true
	elif ability == Globals.abiliyList.DashAir:
		if unlockedDashAir:
			maxDash = +1
		else:
			unlockedDashAir = true
	elif ability == Globals.abiliyList.DashUp:
		unlockedDashUp = true
	elif ability == Globals.abiliyList.DashDown:
		unlockedDashDown = true
	elif ability == Globals.abiliyList.DashWall:
		unlockedDashWall = true
	elif ability == Globals.abiliyList.DashJump:
		unlockedDashJump = true
	elif ability == Globals.abiliyList.DashClimb:
		unlockedDashClimb = true
	elif ability == Globals.abiliyList.Glide:
		unlockedGlide = true
	elif ability == Globals.abiliyList.HookShot:
		unlockedHookShot = true
	elif ability == Globals.abiliyList.Climb:
		unlockedClimb = true
	elif ability == Globals.abiliyList.Grab:
		unlockedGrab = true
	elif ability == Globals.abiliyList.Swim:
		unlockedSwim = true
	elif ability == Globals.abiliyList.SwimDash:
		unlockedSwimDash = true
	elif ability == Globals.abiliyList.Burrow:
		unlockedBurrow = true
	else:
		EventBus.emit_signal("error", "Null Ability Unlocked")
	EventBus.emit_signal("abilityCheck")


#func ability_unlocked(ability: Ability) -> void:
#	abilities.add_child(ability)
#	for i in abilities.get_children():
#		i.initialize(self)

func augment_unlocked(augment: Augment) -> void:
	augments.add_child(augment)
	for i in augments.get_children():
		i.initialize(self)

#LOOKAT: can to ability first?
func can_use_ability(ability: int) -> bool:
	#TODO: add back in unlock check
	
	if ability == Globals.abiliyList.JumpAir and unlockedJumpAir and remainingJumpAir > 0:
		return true
	elif ability == Globals.abiliyList.JumpWall and unlockedJumpWall:
		return true
	elif ability == Globals.abiliyList.Dash and unlockedDash and dashCDTimer.is_stopped():
		return true
	elif ability == Globals.abiliyList.DashAir and unlockedDashAir and remainingDashAir > 0 and dashCDTimer.is_stopped():
		return true
	elif ability == Globals.abiliyList.DashUp and unlockedDashUp and remainingDashUp > 0:
		return true
	elif ability == Globals.abiliyList.DashUp and unlockedDashDown and remainingDashDown > 0:
		return true
	elif ability == Globals.abiliyList.DashWall and unlockedDashUp:
		return true
	elif ability == Globals.abiliyList.DashJump and unlockedDashJump:
		return true
	elif ability == Globals.abiliyList.DashClimb and unlockedDashClimb:
		return true
	elif ability == Globals.abiliyList.Glide and unlockedGlide:
		return true
	elif ability == Globals.abiliyList.HookShot and unlockedHookShot:
		return true
	elif ability == Globals.abiliyList.Climb and unlockedClimb:
		return true
	elif ability == Globals.abiliyList.Grab and unlockedGrab:
		return true
	elif ability == Globals.abiliyList.Swim and unlockedSwim:
		return true
	elif ability == Globals.abiliyList.SwimDash and unlockedSwimDash:
		return true
	elif ability == Globals.abiliyList.Burrow and unlockedBurrow:
		return true
	
	return false

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
	EventBus.emit_signal("abilityCheck")


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
	EventBus.emit_signal("abilityCheck")


func set_jump_air(amount: int) -> void:
	remainingJumpAir = clamp(remainingJumpAir + amount, 0, maxJumpAir)


func set_dash(amount: int) -> void:
	remainingDashAir = clamp(remainingDashAir + amount, 0, maxDash)
