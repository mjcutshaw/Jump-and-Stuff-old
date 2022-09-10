extends PlayerToTarget
#TODO: rename script, 

onready var player: Player = owner
export (Globals.abilityTargetType) var abilityTarget
onready var lineToTarget: Line2D = $Line2D
onready var aim: Area2D = $Aim
signal found_target(target_global_position)

#FIXME: grabbing offset global position

func _ready() -> void:
	#TODO: connect signal of player reaching to clear points
	if abilityTarget == Globals.abilityTargetType.null:
		EventBus.emit_signal("error", str("player target aim type not set " + str(name)))
	if abilityTarget == Globals.abilityTargetType.hookShot:
		aim.set_collision_mask_bit(CollisionLayers.HOOKSHOT, true)
	if abilityTarget == Globals.abilityTargetType.grappleHook:
		aim.set_collision_mask_bit(CollisionLayers.GRAPPLEHOOK, true)
	if abilityTarget == Globals.abilityTargetType.burrow:
		aim.set_collision_mask_bit(CollisionLayers.BURROW, true)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("grapple"):
		if aim.target != null:
			EventBus.emit_signal("hookshotTarget", aim.target.global_position)
			lineToTarget.set_target_position(aim.target.global_position)
			EventBus.emit_signal("debug1", "target: ", aim.target.global_position)
	

func _physics_process(delta: float) -> void:
	aim_direction()
	if player.aimDirection == Vector2.ZERO:
		aim.aimIndicator.visible = false
		aim.targetIndicator.visible = false
	else:
		aim.aimIndicator.visible = true
		aim.aim()
		aim.target = aim.find_best_target()
		aim.set_target(aim.target)
		

func aim_direction() -> void:
	player.aimStrength =  Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	#todo: change deadzone to settings
	var deadzone_radius: = 0.2
	
	if player.aimStrength.length() > deadzone_radius:
		player.aimDirection = player.aimStrength
	else:
		player.aimDirection = Vector2.ZERO
