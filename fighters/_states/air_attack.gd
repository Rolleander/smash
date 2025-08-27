class_name AIR_ATTACK extends AirbornState

var _move: FighterMove

func enter(previous_state_path: String):
	_move = fighter.moves.pop_move()

func update(_delta: float) -> void:
	super.update(_delta)
	air_movement(false, 0)
	if !_move.running:
		next("AIR")
