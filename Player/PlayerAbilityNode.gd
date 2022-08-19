extends PlayerStatsNode
class_name PlayerAbilitiesNode

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
onready var unlockedDashAir: bool = Abilities.unlockedDashAir
onready var unlockedDashLeft: bool = Abilities.unlockedDashLeft
onready var unlockedDashRight: bool = Abilities.unlockedDashRight
onready var unlockedDashSide: bool = Abilities.unlockedDashSide
onready var unlockedDashUp: bool = Abilities.unlockedDashUp
onready var unlockedDashDown: bool = Abilities.unlockedDashDown
onready var unlockedDashWall: bool = Abilities.unlockedDashWall
onready var unlockedGlide: bool = Abilities.unlockedGlide
onready var unlockedGroundPound: bool = Abilities.unlockedGroundPound
onready var unlockedGrapple: bool = Abilities.unlockedGrapple
onready var unlockedClimb: bool = Abilities.unlockedClimb
onready var unlockedClimbLeft: bool = Abilities.unlockedClimbLeft
onready var unlockedClimbRight: bool = Abilities.unlockedClimbRight


onready var maxJump: int = Abilities.maxJump
onready var maxJumpAir: int = Abilities.maxJumpAir
onready var maxDash: int = Abilities.maxDash

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
		unlockedJump = true
		unlockedJumpAir = true
		unlockedDashDown = true
		unlockedDashSide = true
		unlockedDashUp = true
	elif ability == Abilities.abiliyList.Jump:
		unlockedJump = true
	elif ability == Abilities.abiliyList.JumpAir:
		if unlockedJumpAir == true:
			maxJumpAir = +1
		else:
			unlockedJumpAir = true
	elif ability == Abilities.abiliyList.Dash:
		#TODO: logic for increased dashes
		unlockedDashSide = true
		unlockedDashUp = true
		unlockedDashDown = true
	elif ability == Abilities.abiliyList.DashSide:
		if unlockedDashSide == true:
			maxDash += 1
		else:
			unlockedDashSide = true
	elif ability ==  Abilities.abiliyList.DashUp:
		unlockedDashUp = true
	elif ability == Abilities.abiliyList.DashDown:
		unlockedDashDown = true
	else:
		EventBus.emit_signal("error", "Null Ability Unlocked")
	EventBus.emit_signal("ability_check")


func ability_unlocked(ability: Ability) -> void:
	abilities.add_child(ability)
	for i in abilities.get_children():
		i.initialize(self)

func augment_unlocked(augment: Augment) -> void:
	augments.add_child(augment)
	for i in augments.get_children():
		i.initialize(self)
