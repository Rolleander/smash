class_name STAND extends State

const WALK_V = 0.1

func enter(previous_state_path: String):
	pass

func update(_delta: float) -> void:
	fighter.animation("IDLE")
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
	elif flick == FlickScan.DIR.DOWN:
		if attack:
			fighter.action = ATTACK.Type.D_SMASH
			return next("ATTACK")
		if fighter.onPlatform():
			return next("DROP")
	elif flick == FlickScan.DIR.LEFT:
		fighter.turn(true)
		if attack:
			fighter.action = ATTACK.Type.F_SMASH
			return next("ATTACK")
		fighter.velocity.x = - fighter.atts.dashSpeed
		return next("DASH")
	elif flick == FlickScan.DIR.RIGHT:
		fighter.turn(false)
		if attack:
			fighter.action = ATTACK.Type.F_SMASH
			return next("ATTACK")
		fighter.velocity.x = fighter.atts.dashSpeed
		return next("DASH")
	elif noFlick:
		if attack:
			if max(abs(stick_x), abs(stick_y)) >= WALK.TILT_LIMIT:
				if stick_x >= WALK.TILT_LIMIT:
					fighter.turn(false)
				elif stick_x <= WALK.TILT_LIMIT *-1:
					fighter.turn(true)
				var yStronger = abs(stick_y) >= abs(stick_x)
				var tilt = stick_y if yStronger else stick_x
				if tilt >= WALK.TILT_LIMIT:			
					fighter.action = ATTACK.Type.D_TILT if yStronger else ATTACK.Type.F_TILT
					return next("ATTACK")
				elif tilt <= WALK.TILT_LIMIT * -1:
					fighter.action = ATTACK.Type.U_TILT if yStronger else ATTACK.Type.F_TILT
					return next("ATTACK")
			fighter.action = ATTACK.Type.NORMAL				
			return next("ATTACK")	
		if stick_x > WALK_V:
			fighter.turn(false)
			return next("WALK")
		elif stick_x < WALK_V * -1:
			fighter.turn(true)
			return next("WALK")
			
	fighter.dampenHorizontalMovement()
