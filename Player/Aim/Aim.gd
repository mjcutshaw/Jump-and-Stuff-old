extends Area2D

#TODO: two indicators, grapple and burrow

onready var player: Player = owner
onready var raycast: RayCast2D = $RayCast2D
onready var aimIndicator: Node2D = $AimIndicator
onready var targetIndicator: Node2D = $TargetIndicator
var targetGrapple: GrappleTarget setget set_target_grapple

func _ready() -> void:
	aimIndicator.visible = false


func _unhandled_input(event: InputEvent) -> void:
	pass

func _physics_process(delta: float) -> void:
	targetGrapple = find_best_target()
	aim_direction()
	if player.aimDirection == Vector2.ZERO:
		aimIndicator.visible = false
	else:
		aimIndicator.visible = true
		aim()

func find_best_target() -> GrappleTarget:
	var closestTarget: GrappleTarget = null
	var targets = get_overlapping_areas()
	for t in targets:
		if not t.is_active:
			continue
		
		raycast.cast_to = t.global_position - global_position
		
		if raycast.is_colliding():
			continue
		
		closestTarget = t
		break
	return closestTarget

func has_target_grapple() -> bool:
	return targetGrapple != null


func set_target_grapple(target: GrappleTarget) -> void:
	targetGrapple = target
	targetIndicator.visible = has_target_grapple()
	if target:
		targetGrapple.global_position = target.global_position


func aim_direction() -> void:
	player.aimStrength =  Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	#todo: change deadzone to settings
	var deadzone_radius: = 0.2
	
	if player.aimStrength.length() > deadzone_radius:
		player.aimDirection = player.aimStrength
	else:
		player.aimDirection = Vector2.ZERO

func aim()-> void:
	var cast: Vector2 = player.aimDirection.normalized() * raycast.cast_to.length()
	var angle: = cast.angle()
	rotation = angle
	raycast.force_raycast_update()
