extends Node

#TODO: move constants out of Global, don't need to be autoloaded

const TILE_SIZE: int = 32

const LEFT = -1
const RIGHT = 1
const UP = -1
const DOWN = 1
const ZERO = Vector2.ZERO

#TODO: Move to settings
var dashSideColor: Color = Color.blue
var dashUpColor: Color = Color.red
var dashDownColor: Color = Color.green
var dashColor: Color = Color.blue #TODO: change to cycle through dash colors
var dashUsedColor: Color = Color.gray
var hookshotColor: Color = Color.purple
var grappleColor: Color = Color.violet
var burrowColor: Color = Color.orange
var jumpColor: Color = Color.brown
var pogoColor: Color = Color.floralwhite
var bashColor: Color = Color.yellow
#var spinColor: Color = Color.orange
var allColor: Color = Color.white

#TODO: Add in airjump tracker


enum statList {null, MoveSpeed, JumpHeight, HealthMax}
enum abiliyList {
	null,
	All,
	JumpAir,
	JumpWall,
	DashGround,
	DashAir,
	DashUp,
	DashDown,
	DashWall,
	DashClimb,
	DashJump,
	Glide,
	HookShot,
	Climb,
	Grab,
	Swim,
	SwimDash,
	Burrow,
	}
enum abilityTargetType {null, hookShot, grappleHook, burrow}
