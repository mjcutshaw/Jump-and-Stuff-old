extends Resource
class_name PlayerStats

#TODO: makes based on each other for easy boosting
#FIXME: player is too fase


export var healthMax: int = 4
var health: int = 3

export var moveSpeed: int = 15
export var accelerationGround: float = .3
export var frictionGround: float = .5
export var frictionSkid: float = 1.0

export var jumpHeightMax: float = 3.25
export var jumpHeightMin: int = 10
export var jumpHeightApex: float = 40.0
export var jumpTimeToPeak: float = 0.5
export var jumpTimeToDescent: float = 0.25
export var jumpTimeAtApex: float = 0.8
export var jumpDoubleVelocityModifier: float = 1.25
export var jumpTripleVelocityModifier: float = 1.5
export var jumpCrouchVelocityModifier: float = 1.75
export var jumpLongVelocityModifier: float = 1.35
export var dashJumpBoostVelocityModifier: float = 1.25
export var accelerationAir: float = .5
export var frictionAir: float = .7


export var terminalVelocity: int = 30
export var moveSpeedApex: int = 13 

export var glideSpeedModifier: float = 2.0
export var glideFallSpeedModifier: float = 6.0
export var glideGravityModifier: float = 10.0

export var jumpBoostTime: float = 0.10 #DASH
export var dashDuration = 0.3
export var dashDistance: int = 12
export var dashJumpModifier: float = 1.5
export var dashJumpVelocityModifier: float = 5

# WALL SLIDE #
export var wallSlideSpeed: int = 2
export var wallQuickSlideSpeed: int = 4

export var swimSpeedModifier: float = 3.0
