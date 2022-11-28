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
var dashAllColor: Color = Color.purple
var swimDashColor: Color = Color.gray
var hookShotColor: Color = Color.violet
var burrowColor: Color = Color.orange
var jumpColor: Color = Color.brown
var pogoColor: Color = Color.floralwhite
var bashColor: Color = Color.yellow
#var spinColor: Color = Color.orange
var allColor: Color = Color.white

#TODO: Add in airjump tracker


enum statList {null, MoveSpeed, JumpHeight, HealthMax}

enum abilityTargetType {null, hookShot, grappleHook, burrow}
