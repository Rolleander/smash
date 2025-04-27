class_name WALK extends GroundState


func update(_delta: float) -> void:
	super.update(_delta)
	fighter.animation("WALK")
	Sounds.playFootSteps(fighter, frame, 12)
	if CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("JUMP_SQUAT")
	
	if startAttack(true, true):
		return

	if stick_x > 0:
		fighter.turn(false)
		fighter.velocity.x = fighter.atts.walkSpeed * stick_x
	elif stick_x < 0:
		fighter.turn(true)
		fighter.velocity.x = fighter.atts.walkSpeed * stick_x
	else:
		next("STAND")
