class_name WALK extends State

const TILT_LIMIT = 0.6

func update(_delta: float) -> void:
	fighter.animation("WALK")
	Sounds.playFootSteps(fighter, frame, 12)
	if CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("JUMP_SQUAT")
	var stick_x = CInput.axis(fighter, CInput.AXIS.X)
	var stick_y = CInput.axis(fighter, CInput.AXIS.Y)
	var flick = fighter.flickScan.flicked()
	var noFlick = fighter.flickScan.noFlick()
	var attack = fighter.flickScan.wantsAttack()

	if flick == FlickScan.DIR.UP and attack:
		fighter.action = ATTACK.Type.U_SMASH
		return next("ATTACK")
	elif flick == FlickScan.DIR.DOWN and attack:
		fighter.action = ATTACK.Type.D_SMASH
		return next("ATTACK")
	elif flick == FlickScan.DIR.LEFT and attack:
		fighter.turn(true)
		fighter.action = ATTACK.Type.F_SMASH
		return next("ATTACK")
	elif flick == FlickScan.DIR.RIGHT and attack:
		fighter.turn(false)
		fighter.action = ATTACK.Type.F_SMASH
		return next("ATTACK")
	elif noFlick and (attack or CInput.justPressed(fighter, CInput.CTRL.ATTACK)):			
		if stick_x > 0:
			fighter.turn(false)
		elif stick_x < 0:
			fighter.turn(true)
		var yStronger = abs(stick_y) >= abs(stick_x)
		var tilt = stick_y if yStronger else stick_x
		if tilt >= TILT_LIMIT:			
			fighter.action = ATTACK.Type.D_TILT if yStronger else ATTACK.Type.F_TILT
			return next("ATTACK")
		elif tilt <= TILT_LIMIT * -1:
			fighter.action = ATTACK.Type.U_TILT if yStronger else ATTACK.Type.F_TILT
			return next("ATTACK")
		fighter.action = ATTACK.Type.NORMAL				
		return next("ATTACK")

	if stick_x > 0:
		fighter.turn(false)
		fighter.velocity.x = fighter.atts.walkSpeed * stick_x
	elif stick_x < 0:
		fighter.turn(true)
		fighter.velocity.x = fighter.atts.walkSpeed * stick_x
	else:
		next("STAND")
