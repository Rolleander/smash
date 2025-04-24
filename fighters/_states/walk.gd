class_name WALK extends State

func update(_delta: float) -> void:
	fighter.animation("WALK")
	Sounds.playFootSteps(fighter, frame, 12)
	if CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("JUMP_SQUAT")
	var stick_x = CInput.axis(fighter, CInput.AXIS.X)
	if stick_x > 0:
		fighter.velocity.x = fighter.atts.walkSpeed * stick_x
		fighter.turn(false)
	elif stick_x < 0:
		fighter.velocity.x = fighter.atts.walkSpeed * stick_x
		fighter.turn(true)
	else:
		next("STAND")
