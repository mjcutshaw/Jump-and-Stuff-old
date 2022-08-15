extends Position2D

func _enter_tree() -> void:
	EventBus.connect("startingLocation", self, "check_multiple_locations")
	set_starting_location()

func set_starting_location() -> void:
	CheckpointSystem.set_respawn(global_position)
	CheckpointSystem.startingArea = global_position
	EventBus.emit_signal("startingLocation")

func check_multiple_locations() -> void:
	if CheckpointSystem.startingArea != global_position:
		print("multiple starting location" + str(global_position))
