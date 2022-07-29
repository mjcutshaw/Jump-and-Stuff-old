extends Resource
class_name PlayerStats



var moveSpeed: int = 20 * Globals.TILE_SIZE
var acceleration: float = 0.2
var friction: float = 0.1
var crouchFriction: float = 0.02

var jumpHeightMax: float = 4.5 * Globals.TILE_SIZE
var jumpHeightMin: int = 10
var jumpTimeToPeak: float = 0.5
var jumpTimeToDescent: float = 0.25
var jumpTimeAtApex: float = 0.8
var jumpApexHeight: float = 40
var jumpDoubleVelocityModifier: float = 1.25
var jumpTripleVelocityModifier: float = 1.5
var jumpCrouchVelocityModifier: float = 1.75
var jumpLongVelocityModifier: float = 1.35
var dashJumpBoostVelocityModifier: float = 1.25

var terminalVelocity: int = 30 * Globals.TILE_SIZE
var moveSpeedApex: int = 13 * Globals.TILE_SIZE

var glideSpeedModifier: int = 2
var glideFallSpeedModifier: int = 6

var jumpBoostTime: float = 0.10 #DASH
var dashTime = 0.3
var dashDistance: int = 10 * Globals.TILE_SIZE

# WALL SLIDE #
var slideSpeed: int = 7 * Globals.TILE_SIZE
var quickSlideSpeed: int = 12 * Globals.TILE_SIZE
