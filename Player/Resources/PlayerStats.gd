extends Resource
class_name PlayerStats

#TODO: makes based on each other for easy boosting


export var healthMax: int = 4
var health: int = 3

export var moveSpeed: int = 10
export var acceleration: float = 0.1
export var friction: float = 0.1
export  var crouchFriction: float = 0.02

export var jumpHeightMax: float = 3.25
export var jumpHeightMin: int = 10
export var jumpTimeToPeak: float = 0.5
export var jumpTimeToDescent: float = 0.25
export var jumpTimeAtApex: float = 0.8
export var jumpApexHeight: float = 40
export var jumpDoubleVelocityModifier: float = 1.25
export var jumpTripleVelocityModifier: float = 1.5
export var jumpCrouchVelocityModifier: float = 1.75
export var jumpLongVelocityModifier: float = 1.35
export var dashJumpBoostVelocityModifier: float = 1.25

export var terminalVelocity: int = 30
export var moveSpeedApex: int = 13 

export var glideSpeedModifier: int = 2
export var glideFallSpeedModifier: int = 6

export var jumpBoostTime: float = 0.10 #DASH
export var dashTime = 0.3
export var dashDistance: int = 10 

# WALL SLIDE #
export var slideSpeed: int = 7
export var quickSlideSpeed: int = 12
