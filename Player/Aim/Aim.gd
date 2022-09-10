extends Area2D

#TODO: two indicators, grapple and burrow, change to hookshot
#make resuble and parent tell target. might be easier to have generic target and control the layers they look at

onready var player: Player = owner
onready var raycast: RayCast2D = $RayCast2D
onready var aimIndicator: Node2D = $AimIndicator
onready var targetIndicator: Node2D = $TargetIndicator
var target: Target

func _ready() -> void:
	aimIndicator.visible = false
	raycast.set_as_toplevel(true)

func _unhandled_input(event: InputEvent) -> void:
	pass


func find_best_target() -> Target:
	var closestTarget: Target = null
	var targets = get_overlapping_areas()
	for t in targets:
		if not t.is_active:
			continue
		
		raycast.global_position = global_position
		raycast.cast_to = t.global_position - global_position
		raycast.force_update_transform()
		
		if raycast.is_colliding():
			continue
			
		
		closestTarget = t
	return closestTarget

func has_target() -> bool:
	return target != null


func set_target(value: Target) -> void:
	target = value
	targetIndicator.visible = target != null
	if target:
		targetIndicator.global_position = target.global_position


func aim() -> void:
	var cast: Vector2 = player.aimDirection.normalized() * raycast.cast_to.length()
	var angle: = cast.angle()
	rotation = angle
	raycast.force_raycast_update()
