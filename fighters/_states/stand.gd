class_name STAND extends GroundState

const WALK_V = 0.1

func enter(previous_state_path: String):
	pass

func update(_delta: float) -> void:
	super.update(_delta)
	fighter.animation("IDLE")
	if CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("JUMP_SQUAT")
		
	fighter.dampenHorizontalMovement()
	
	if !flickScanDone:
		return
	
	if startAttack(true, true):
		return
		
	if flick == FlickScan.DIR.DOWN and fighter.onPlatform():		
		return next("DROP")
	elif flick == FlickScan.DIR.LEFT:
		fighter.turn(true)
		fighter.velocity.x = - fighter.atts.dashSpeed
		return next("DASH")
	elif flick == FlickScan.DIR.RIGHT:
		fighter.turn(false)
		fighter.velocity.x = fighter.atts.dashSpeed
		return next("DASH")
	
	if stick_x > WALK_V:
		fighter.turn(false)
		return next("WALK")
	elif stick_x < WALK_V * -1:
		fighter.turn(true)
		return next("WALK")
			
	if CInput.pressed(fighter, CInput.CTRL.DOWN):
		return next("CROUCH")
