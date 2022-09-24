extends Area2D

#TODO: will need multiple detectors for abilities

onready var player: Player = owner
onready var raycast: RayCast2D = $RayCast2D
onready var aimIndicator: Node2D = $AimIndicator
onready var targetIndicator: Node2D = $TargetIndicator
var target: Target


func _ready() -> void:
	set_collision_mask_bit(CollisionLayers.TARGET, true)
	aimIndicator.visible = false
	raycast.set_as_toplevel(true)


func _physics_process(delta: float) -> void:
	aim_direction()
	if player.aimDirection == Vector2.ZERO:
		aimIndicator.visible = false
		targetIndicator.visible = false
		player.targetHookShot = null
	else:
		aimIndicator.visible = true
		aim()
		target = find_best_target()
		set_target(target)
		

func aim_direction() -> void:
	player.aimStrength =  Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	#todo: change deadzone to settings
	var deadzone_radius: = 0.2
	
	if player.aimStrength.length() > deadzone_radius:
		player.aimDirection = player.aimStrength
	else:
		player.aimDirection = Vector2.ZERO


func find_best_target() -> Target:
	var closestTarget: Target = null
	var targets = get_overlapping_areas()
	for t in targets:
		if not t.isActive:
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
		player.targetHookShot = target
	else:
		player.targetHookShot = null


func aim() -> void:
	var cast: Vector2 = player.aimDirection.normalized() * raycast.cast_to.length()
	var angle: = cast.angle()
	rotation = angle
	raycast.force_raycast_update()
