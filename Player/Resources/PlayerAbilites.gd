extends Resource
class_name PlayerAbilities

#TODO: look into makin abilities a compent system like hook demos
#TODO: add these onto player scrip like PlayerStatsNode
#TODO: add more conditions for unlocks
#TODO: all abilities should get an upgrade and shards/modifires/charms
enum abiliyList {
	Null,
	All,
	Jump,
	JumpAir,
	JumpLong,
	JumpCrouch, 
	JumpWall,
	Dash,
	DashSide,
	DashUp,
	DashDown,
	DashWall,
	Glide,
	GroundPound,
	Grapple,
	Climb,
	}


var unlockedJump: bool = false
var unlockedJumpAir: bool = false
var unlockedJumpCrouch: bool = false
var unlockedJumpLong: bool = false
var unlockedJumpWall: bool = false
var unlockedJumpWallLeft: bool = false
var unlockedJumpWallRight: bool = false
var unlockedDashAir: bool = false
var unlockedDashLeft: bool = false
var unlockedDashRight: bool = false
var unlockedDashSide: bool = false
var unlockedDashUp: bool = false
var unlockedDashDown: bool = false
var unlockedDashWall: bool = false
var unlockedGlide: bool = false
var unlockedGroundPound: bool = false
var unlockedGrapple: bool = false
var unlockedClimb: bool = false
var unlockedClimbLeft: bool = false
var unlockedClimbRight: bool = false


var maxJump: int = 1
var maxJumpAir: int = 0
var maxDash: int = 1


func unlock_ability(ability: int) -> void:
	if ability == abiliyList.All:
		unlockedJump = true
		unlockedJumpAir = true
		unlockedDashDown = true
		unlockedDashSide = true
		unlockedDashUp = true
	elif ability == abiliyList.Jump:
		unlockedJump = true
	elif ability == abiliyList.JumpAir:
		if unlockedJumpAir == true:
			maxJumpAir = +1
		else:
			unlockedJumpAir = true
	elif ability == abiliyList.Dash:
		#TODO: logic for increased dashes
		unlockedDashSide = true
		unlockedDashUp = true
		unlockedDashDown = true
	elif ability == abiliyList.DashSide:
		if unlockedDashSide == true:
			maxDash += 1
		else:
			unlockedDashSide = true
	elif ability ==  abiliyList.DashUp:
		unlockedDashUp = true
	elif ability == abiliyList.DashDown:
		unlockedDashDown = true
	else:
		print("Null Ability Unlocked")
	EventBus.emit_signal("ability_check")
