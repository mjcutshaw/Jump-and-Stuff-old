extends Node


signal update_stats
signal update_abilities

signal playerSpawned
signal playerDied
signal jump
signal fall
signal walk
signal idle
signal landed
signal playerGrounded(isGrounded)
signal playerHealthChanged(amount)
signal playerHealthMaxChanged(amount)
signal playerStatChange(stat, amount)

signal healthUI(amount)
#signal dashed
#
#signal bonked
#
#signal ability_check
#signal ability_unlocked(data)

signal checkpoint
signal startingLocation
#
#signal settings_update
#
#signal level_completed(data)
#signal level_started(data)
#signal change_scene(data)
#signal free_look_camera(data)
#
#signal game_paused(data)
#signal game_exit
