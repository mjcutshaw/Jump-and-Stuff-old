extends PlayerStatsNode
class_name PlayerAbilitiesNode

#LOOKAT: get rid of resource?
#TODO: ability modifiers like melting/cooling to open areas
var Abilities: Resource = preload("res://Resources/PlayerAbilities.tres")

#onready var abilities: Node = $Abilities
onready var augments: Node = $Augments

onready var unlockedJumpAir: bool = Abilities.unlockedJumpAir
onready var unlockedJumpWall: bool = Abilities.unlockedJumpWall
onready var unlockedDashGround: bool = Abilities.unlockedDashGround
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
	
	if ability == PlayerAbilities.list.All:
		#TODO: for look todo all abilities
		unlockedJumpAir = true
		unlockedJumpWall = true
		unlockedDashGround = true
		unlockedDashAir = true
		unlockedDashUp = true
		unlockedDashDown = true
		unlockedDashWall = true
		unlockedDashJump = true
		unlockedDashClimb = true
		unlockedGlide = true
		unlockedHookShot = true
		unlockedClimb = true
		unlockedGrab = true
		unlockedSwim = true
		unlockedSwimDash = true
		unlockedBurrow = true
		
	elif ability == PlayerAbilities.list.JumpAir:
		if unlockedJumpAir:
			maxJumpAir = +1
		else:
			unlockedJumpAir = true
	elif ability == PlayerAbilities.list.JumpWall:
		unlockedJumpWall = true
	elif ability == PlayerAbilities.list.DashGround:
		unlockedDashGround = true
	elif ability == PlayerAbilities.list.DashAir:
		if unlockedDashAir:
			maxDash = +1
		else:
			unlockedDashAir = true
	elif ability == PlayerAbilities.list.DashUp:
		unlockedDashUp = true
	elif ability == PlayerAbilities.list.DashDown:
		unlockedDashDown = true
	elif ability == PlayerAbilities.list.DashWall:
		unlockedDashWall = true
	elif ability == PlayerAbilities.list.DashJump:
		unlockedDashJump = true
	elif ability == PlayerAbilities.list.DashClimb:
		unlockedDashClimb = true
	elif ability == PlayerAbilities.list.Glide:
		unlockedGlide = true
	elif ability == PlayerAbilities.list.HookShot:
		unlockedHookShot = true
	elif ability == PlayerAbilities.list.Climb:
		unlockedClimb = true
	elif ability == PlayerAbilities.list.Grab:
		unlockedGrab = true
	elif ability == PlayerAbilities.list.Swim:
		unlockedSwim = true
	elif ability == PlayerAbilities.list.SwimDash:
		unlockedSwimDash = true
	elif ability == PlayerAbilities.list.Burrow:
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
	
	if ability == PlayerAbilities.list.JumpAir and unlockedJumpAir and remainingJumpAir > 0:
		return true
	elif ability == PlayerAbilities.list.JumpWall and unlockedJumpWall:
		return true
	elif ability == PlayerAbilities.list.DashGround and unlockedDashGround and dashCDTimer.is_stopped():
		return true
	elif ability == PlayerAbilities.list.DashAir and unlockedDashAir and remainingDashAir > 0 and dashCDTimer.is_stopped():
		return true
	elif ability == PlayerAbilities.list.DashUp and unlockedDashUp and remainingDashUp > 0:
		return true
	elif ability == PlayerAbilities.list.DashUp and unlockedDashDown and remainingDashDown > 0:
		return true
	elif ability == PlayerAbilities.list.DashWall and unlockedDashUp:
		return true
	elif ability == PlayerAbilities.list.DashJump and unlockedDashJump:
		return true
	elif ability == PlayerAbilities.list.DashClimb and unlockedDashClimb:
		return true
	elif ability == PlayerAbilities.list.Glide and unlockedGlide:
		return true
	elif ability == PlayerAbilities.list.HookShot and unlockedHookShot:
		return true
	elif ability == PlayerAbilities.list.Climb and unlockedClimb:
		return true
	elif ability == PlayerAbilities.list.Grab and unlockedGrab:
		return true
	elif ability == PlayerAbilities.list.Swim and unlockedSwim:
		return true
	elif ability == PlayerAbilities.list.SwimDash and unlockedSwimDash:
		return true
	elif ability == PlayerAbilities.list.Burrow and unlockedBurrow:
		return true
	
	return false

func consume_ability(ability: int, amount: int) -> void:
	#TODO: Use 99 remove all or all a third input to do that
	if ability == PlayerAbilities.list.All:
		set_jump_air(-amount)
		set_dash(-amount)
	elif ability == PlayerAbilities.list.JumpAir:
		set_jump_air(-amount)
	elif ability == PlayerAbilities.list.DashAir:
		set_dash(-amount)
	else:
		print("Null Ability Consume")
	EventBus.emit_signal("abilityCheck")


func reset_ability(ability: int) -> void:
	if ability == PlayerAbilities.list.All:
		set_dash(maxDash)
		set_jump_air(maxJumpAir)
	elif ability == PlayerAbilities.list.JumpAir:
		set_jump_air(maxJumpAir)
	elif ability == PlayerAbilities.list.DashAir:
		set_dash(maxDash)
	else:
		print("Null Ability Reset")
	EventBus.emit_signal("abilityCheck")


func set_jump_air(amount: int) -> void:
	remainingJumpAir = clamp(remainingJumpAir + amount, 0, maxJumpAir)


func set_dash(amount: int) -> void:
	remainingDashAir = clamp(remainingDashAir + amount, 0, maxDash)
