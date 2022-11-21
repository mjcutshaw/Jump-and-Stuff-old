extends Node

#TODO: move constants out of Global, don't need to be autoloaded

const TILE_SIZE: int = 32
const GAME_NAME: String = "Jump and Stuff"
const CREATOR: String = "Matt"
const VERSION: String = "0.0.1"

const GROUND: int = 1
const SEMISOLID: int = 2
const PLATFORM: int = 3
const INTERACTABLE: int = 4
const COLLECTIBLES: int = 5
const PLAYER: int = 6
const HAZARD: int = 7


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
	Dash,
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
