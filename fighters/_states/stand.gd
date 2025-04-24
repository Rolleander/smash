class_name STAND extends State

var x_scan: InputScan
var y_scan: InputScan

const WALK_V = 0.1

func enter(previous_state_path: String):
	x_scan = InputScan.new(fighter, 4, InputScan.FlickAxis.X)
	y_scan = InputScan.new(fighter, 3, InputScan.FlickAxis.Y)

func update(_delta: float) -> void:
	fighter.animation("IDLE")
	x_scan.update()
	y_scan.update()
	if CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("JUMP_SQUAT")
	if x_scan.noFlick():
		var stick_x = CInput.axis(fighter, CInput.AXIS.X)
		if stick_x > WALK_V:
			fighter.turn(false)
			return next("WALK")
		elif stick_x < WALK_V * -1:
			fighter.turn(true)
			return next("WALK")
	elif x_scan.flickedNegative():
		fighter.velocity.x = - fighter.atts.dashSpeed
		fighter.turn(true)
		return next("DASH")
	elif x_scan.flickedPositive():
		fighter.velocity.x = fighter.atts.dashSpeed
		fighter.turn(false)
		return next("DASH")
	
	fighter.dampenHorizontalMovement()
	
	if y_scan.flickedPositive() and fighter.onPlatform():
		next("DROP")
