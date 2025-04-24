class_name HITSTUN extends State

func enter(previous_state_path: String):
	_check_bounce(delta)

const bounceFactor = 0.8

func _check_bounce(delta : float):
	if fighter.knockback.knockback <3:
		return
	var bounce = fighter.move_and_collide(fighter.velocity * delta, true, 0.08, true)
	if bounce:
		fighter.velocity = fighter.velocity.bounce(bounce.get_normal())  * bounceFactor
		fighter.knockback.hitstun = round(fighter.knockback.hitstun * bounceFactor)

func update(delta: float):
	_check_bounce(delta)
	if fighter.velocity.x >0:
		fighter.velocity.x -= fighter.knockback.hdecay * 0.5
		fighter.velocity.x = max(0, fighter.velocity.x)
	elif fighter.velocity.x < 0:
		fighter.velocity.x += fighter.knockback.hdecay * 0.5
		fighter.velocity.x = min(0, fighter.velocity.x)
	if fighter.velocity.y < 0:
		fighter.velocity.y += fighter.knockback.vdecay * 0.5
		fighter.velocity.y = min(0, fighter.velocity.y)
	if frame >= fighter.knockback.hitstun:
		return next("AIR")
