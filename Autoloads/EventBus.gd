extends Node


signal update_stats
signal update_abilities

signal playerSpawned
signal playerDied
signal playerJumped
signal playerSuperJumped
signal playerDashed
signal playerGlide
signal fall
signal walk
signal idle
signal landed
signal playerGrounded(isGrounded)
signal playerHealthChanged(amount)
signal playerHealthMaxChanged(amount)
signal playerHealFull
signal playerStatChange(stat, amount)
signal playerAbilityUnlocked(ability)
signal playerAugmentUnlocked(augment)
signal hookshotTarget(target)

signal playerBounced(amount)

signal healthUI(amount)
#signal bonked
#
signal ability_check

signal checkpoint
signal startingLocation
signal setRespawn(name, location)
signal addWaypoint(name, location)
signal teleportPlayerToWaypoint(name)

signal error(info) #TODO: eventually turn this into write error file
signal debugState(info)
signal debugVelocity(info)
signal debug1(type, info)
signal debug2(type, info)
signal debug3(type, info)

## MENU ##
signal returnToGame
signal menuChanged(menu)
#signal settings_update
#
#signal level_completed(data)
#signal level_started(data)
#signal change_scene(data)
#signal free_look_camera(data)
#
#signal game_paused(data)
#signal game_exit
