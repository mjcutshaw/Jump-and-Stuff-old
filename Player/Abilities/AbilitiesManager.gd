extends Node

onready var player = owner

func _ready() -> void:
	EventBus.connect("playerAbilityUnlocked", self, "initialize")

func initialize() -> void:
	for child in get_children():
		pass


func change_ability(ability):
	if ability == Globals.abiliyList.Walk:
		pass
