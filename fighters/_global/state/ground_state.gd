class_name GroundState extends State


func startAttack(allowTilt = true, allowSmash = true):
	var attack = _queryAttacks(true, true)
	if attack != null:
		if stick_x >= TURN_LIMIT:
			fighter.turn(false)
		elif stick_x <= TURN_LIMIT * -1:
			fighter.turn(true)
		fighter.move = attack
		fighter.flickScan.consumeMove()
		next("ATTACK")
		return true
	return false

func _queryAttacks(allowTilt = true, allowSmash = true):
	if !moveBuffering:
		return null
	var special = fighter.flickScan.wantsSpecial()
	if special:
		if max(abs(stick_x), abs(stick_y)) >= TILT_LIMIT:
			var yStronger = abs(stick_y) >= abs(stick_x)
			var tilt = stick_y if yStronger else stick_x
			if tilt >= TILT_LIMIT:
				return Enums.MOVES.D_SPECIAL if yStronger else Enums.MOVES.F_SPECIAL
			elif tilt <= TILT_LIMIT * -1:
				return Enums.MOVES.U_SPECIAL if yStronger else Enums.MOVES.F_SPECIAL
		return Enums.MOVES.SPECIAL
	if flick == FlickScan.DIR.UP:
		return Enums.MOVES.U_SMASH
	elif flick == FlickScan.DIR.DOWN:
		return Enums.MOVES.D_SMASH
	elif flick == FlickScan.DIR.LEFT:
		return Enums.MOVES.F_SMASH
	elif flick == FlickScan.DIR.RIGHT:
		return Enums.MOVES.F_SMASH
	elif noFlick:
		if max(abs(stick_x), abs(stick_y)) >= TILT_LIMIT:
			var yStronger = abs(stick_y) >= abs(stick_x)
			var tilt = stick_y if yStronger else stick_x
			if tilt >= TILT_LIMIT:
				return Enums.MOVES.D_TILT if yStronger else Enums.MOVES.F_TILT
			elif tilt <= TILT_LIMIT * -1:
				return Enums.MOVES.U_TILT if yStronger else Enums.MOVES.F_TILT
		return Enums.MOVES.NORMAL
