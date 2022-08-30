extends Node

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

#const WATER: int = 256
#const LAVA: int = 512
#const SAND: int = 1024
#const SNOW: int = 2048
#const ICE: int = 4096

const LEFT = -1
const RIGHT = 1
const UP = -1
const DOWN = 1

#TODO: Move to settings
var dashSideColor: Color = Color.blue
var dashUpColor: Color = Color.red
var dashDownColor: Color = Color.green
var dashColor: Color = Color.blue #TODO: change to cycle through dash colors
var dashUsedColor: Color = Color.gray
var grappleColor: Color = Color.purple
var jumpColor: Color = Color.brown
var allColor: Color = Color.white
var spinColor: Color = Color.orange
var bashColor: Color = Color.yellow
#TODO: Add in airjump tracker


enum statList {NULL, MoveSpeed, JumpHeight, HealthMax}
enum abiliyList {
	NULL,
	All,
	Walk,
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
