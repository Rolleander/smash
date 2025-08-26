class_name AirbornState extends State

func startAttack():
	var attack = _queryAttacks()
	if attack != null:
		fighter.flickScan.consumeMove()
		fighter.move = attack
		next("AIR_ATTACK")
		return true
	return false

func _queryAttacks():
	if !moveBuffering:
		return null
	var special = fighter.flickScan.wantsSpecial()
	if max(abs(stick_x), abs(stick_y)) >= TILT_LIMIT:
		var yStronger = abs(stick_y) >= abs(stick_x)
		var tilt = stick_y if yStronger else stick_x
		if yStronger:
			if tilt >= TILT_LIMIT:
				if special:
					return Enums.MOVES.D_SPECIAL
				return Enums.MOVES.D_AIR
			elif tilt <= TILT_LIMIT * -1:
				if special:
					return Enums.MOVES.U_SPECIAL
				return Enums.MOVES.U_AIR
		else:
			if special:
				return Enums.MOVES.F_SPECIAL
			if (fighter.facingRight and stick_x >= 0) or (!fighter.facingRight and stick_x <= 0):
				return Enums.MOVES.F_AIR
			return Enums.MOVES.B_AIR
	if special:
		return Enums.MOVES.SPECIAL
	return Enums.MOVES.NORMAL_AIR

func air_movement(allowTurning = true, steerFactor = 1.0, fallFactor = 1.0):
	if fighter.velocity.y < 0:
		fighter.dropFromY = fighter.global_position.y
	if fighter.velocity.y < fighter.atts.fallSpeed:
		fighter.velocity.y += fighter.atts.fallAcceleration * fallFactor
		fighter.velocity.y = clamp(fighter.velocity.y, fighter.velocity.y, fighter.atts.fallSpeed)
	if steerFactor == 0 || !_air_steering(allowTurning, steerFactor):
		fighter.dampenHorizontalMovement(fighter.atts.airAcceleration / 5.0)

func _air_steering(allowTurning = true, factor = 1.0):
	if CInput.pressed(fighter, CInput.CTRL.LEFT) and fighter.velocity.x > fighter.atts.maxAirSpeed * -1:
		fighter.velocity.x -= fighter.atts.airAcceleration
		if allowTurning:
			fighter.turn(true)
		return true
	if CInput.pressed(fighter, CInput.CTRL.RIGHT) and fighter.velocity.x < fighter.atts.maxAirSpeed:
		fighter.velocity.x += fighter.atts.airAcceleration
		if allowTurning:
			fighter.turn(false)
		return true
	return false
