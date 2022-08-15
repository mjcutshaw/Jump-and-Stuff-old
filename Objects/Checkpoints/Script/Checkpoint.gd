extends Interactable
class_name Checkpoint

onready var animPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	connect("area_entered", self, "_on_Checkpoint_entered")
	animPlayer.play("Unused")
	EventBus.connect("checkpoint", self, "check_if_current_checkpoint")

func _on_Checkpoint_entered(body: Player) -> void:
	CheckpointSystem.set_respawn(global_position)
	animPlayer.play("Used")
	EventBus.emit_signal("checkpoint")


func check_if_current_checkpoint():
	if CheckpointSystem.currentRespawn != global_position:
		animPlayer.play("Unused")
