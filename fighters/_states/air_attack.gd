class_name AIR_ATTACK extends AirbornState

func enter(previous_state_path: String):
	var type = Enums.MOVES.keys()[fighter.move]
	print("action => ", type)
	fighter.animation("ATTACK", true)
	

func update(_delta: float) -> void:
	super.update(_delta)
	air_movement(false, 0)
	if !fighter.animations.is_playing():
		next("AIR")
