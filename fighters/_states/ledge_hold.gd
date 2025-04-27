class_name LEDGE_HOLD extends State

const dropY = 20

func enter(previous_state_path: String):
	pass

func update(_delta: float):
	super.update(_delta)
	if frame >= 390: # 3.5 sec
		return letGo(false)
	if CInput.justPressed(fighter, CInput.CTRL.DOWN):
		fighter.fastFall = true
		return letGo()
	if CInput.justPressed(fighter, CInput.CTRL.LEFT):
		if fighter.facingRight:
			return letGo()
		else:
			return next("LEDGE_CLIMB")
	elif CInput.justPressed(fighter, CInput.CTRL.RIGHT):
		if fighter.facingRight:
			return next("LEDGE_CLIMB")
		else:
			return letGo()
	#elif CInput.justPressed(fighter, CInput.CTRL.SHIELD):
		#return next("LEDGE_ROLL")
	elif CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("LEDGE_JUMP")


func letGo(regrabCancel = true):
	if regrabCancel:
		fighter.regrabPause += 30
	fighter.position.y += dropY
	next("AIR")
