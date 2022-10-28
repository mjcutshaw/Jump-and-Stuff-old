extends Node


signal updateStats
signal updateAbilities

signal playerTeleported
signal playerSpawned
signal playerDied
signal playerJumped
signal playerSuperJumped
signal playerDashed
signal playerGlide
signal playerBonked
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
signal abilityCheck

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
signal settingsUpdate
signal saveGame


