extends Node
class_name BaseState

enum State {
	Null,
	Spawn,
	Die,
	Idle,
	Walk,
	Jump,
	JumpAir,
	JumpWall,
	Apex,
	Fall,
	Dash,
	DashVertical,
	DashWall,
	DashClimb,
	DashJump,
	Glide,
	WallSlide,
	WallGrab,
	WallClimb,
	GroundPound,
	Swim,
	SwimDash,
}

var player: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func handle_input(event: InputEvent) -> int:
	return State.Null

func visual(delta: float) -> void:
	pass

func physics(delta: float) -> void:
	pass

func state_check(delta: float) -> int:
	return State.Null
