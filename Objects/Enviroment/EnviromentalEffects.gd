extends Area2D
class_name EnviromentalEffects


#LOOKAT: making a global
enum directions {null, UP, UPLEFT, UPRIGHT, LEFT, RIGHT, DOWN, DOWNLEFT, DOWNRIGHT}

const UP = Vector2.UP
const UPLEFT = Vector2(-1, -1)
const UPRIGHT = Vector2(1, -1)
const LEFT = Vector2.LEFT
const RIGHT = Vector2.RIGHT
const DOWN = Vector2.DOWN
const DOWNLEFT = Vector2(-1, 1)
const DOWNRIGHT = Vector2(1, 1)


export var strength: int = 64
#TODO: send to Actors
export (directions) var direction
#TODO: into strength

#TOADD: water jets, water fountains
