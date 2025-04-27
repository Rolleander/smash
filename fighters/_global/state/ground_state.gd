class_name GroundState extends State


func startAttack(allowTilt = true, allowSmash = true):
	var attack = _queryAttacks(true, true)
	if attack != null:
		if stick_x >= TURN_LIMIT:
			fighter.turn(false)
		elif stick_x <= TURN_LIMIT * -1:
			fighter.turn(true)
		fighter.action = attack
		fighter.flickScan.consumeAttack()
		next("ATTACK") 		
		return true
	return false

func _queryAttacks(allowTilt = true, allowSmash = true):	
	if !attack:
		return null
	if flick == FlickScan.DIR.UP:
		return ATTACK.Type.U_SMASH
	elif flick == FlickScan.DIR.DOWN:
		return ATTACK.Type.D_SMASH
	elif flick == FlickScan.DIR.LEFT:
		return ATTACK.Type.F_SMASH
	elif flick == FlickScan.DIR.RIGHT:
		return ATTACK.Type.F_SMASH
	elif noFlick:
		if max(abs(stick_x), abs(stick_y)) >= TILT_LIMIT:	
			var yStronger = abs(stick_y) >= abs(stick_x)
			var tilt = stick_y if yStronger else stick_x
			if tilt >= TILT_LIMIT:			
				return ATTACK.Type.D_TILT if yStronger else ATTACK.Type.F_TILT
			elif tilt <= TILT_LIMIT * -1:
				return ATTACK.Type.U_TILT if yStronger else ATTACK.Type.F_TILT
		return ATTACK.Type.NORMAL	
