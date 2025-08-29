extends Node

func registerRescueMoveRestriction(move: FighterMove) -> void:
	var fighter = move.fighter
	move.on_start.connect(func(): move.allowed = false)
	fighter.on_landing.connect(func(): move.allowed = true)
	fighter.on_spawn.connect(func(): move.allowed = true)
	fighter.on_ledge_catch.connect(func(): move.allowed = true)
