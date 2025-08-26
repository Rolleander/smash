class_name ATTACK extends AirbornState

func enter(previous_state_path: String):
	var type = Enums.MOVES.keys()[fighter.move]
	print("action => ", type)
	if CInput.pressed(fighter, CInput.CTRL.UP):
		fighter.animation("ATTACK_UP", true)
	else:
		fighter.animation("ATTACK", true)
	var dampen = fighter.atts.traction * 10
	if fighter.move == Enums.MOVES.DASH:
		dampen = fighter.atts.traction * 3
	fighter.dampenHorizontalMovement(dampen)

func update(_delta: float) -> void:
	super.update(_delta)
	
	# sliding into air
	if not fighter.rcGroundL.is_colliding() and not fighter.rcGroundR.is_colliding():
		air_movement(false, 0, 0.5)
		
	if !fighter.animations.is_playing():
		next("STAND")
