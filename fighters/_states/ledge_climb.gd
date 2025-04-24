class_name LEDGE_CLIMB extends State

const climbSpeed = -7

func enter(previous_state_path: String):
	pass

func update(_delta: float):
	if frame % 4 == 0:
		fighter.position.y += climbSpeed
	if frame > 15 && frame % 3 == 0:
		fighter.position.x += 10 * fighter.direction()
	if frame == 25:
		fighter.velocity.x = 0
		fighter.velocity.y = 0
	if frame == 30:
		if fighter.grabbingLedge:
			fighter.grabbingLedge.grabbedBy = null
		fighter.grabbingLedge = null
		fighter.regrabPause = 0
		next("STAND")
