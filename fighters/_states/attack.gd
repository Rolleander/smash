class_name ATTACK extends AirbornState

var _move: FighterMove

func enter(previous_state_path: String):
	var dampen = fighter.atts.traction * 10
	_move = fighter.moves.pop_move()
	if _move.type == Moves.TYPE.DASH:
		dampen = fighter.atts.traction * 3
	fighter.dampenHorizontalMovement(dampen)

func update(_delta: float) -> void:
	super.update(_delta)
	
	# sliding into air
	if not fighter.rcGroundL.is_colliding() and not fighter.rcGroundR.is_colliding():
		air_movement(false, 0, 0.5)
		
	if !_move.running:
		next("STAND")
