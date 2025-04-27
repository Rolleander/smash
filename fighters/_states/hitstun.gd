class_name HITSTUN extends State

var bounced = false
var tumbling = false

func enter(previous_state_path: String):
	bounced = false
	fighter.animation("HITSTUN", true)

func exit() -> void:
	pass

func update(delta: float):
	super.update(delta)
	if fighter.knockback.knockback >= 3:
		if Collision.checkSurfaceBounce(fighter, delta, 0.8) == Collision.BounceResult.BOUNCE:
			bounced = true
	if bounced:
		fighter.dampenHorizontalMovement(fighter.atts.airAcceleration / 5.0)
	else:
		fighter.dampenHorizontalMovement(fighter.knockback.hdecay * 0.5)
		if fighter.velocity.y < 0:
			fighter.velocity.y += fighter.knockback.vdecay * 0.5
			fighter.velocity.y = min(0, fighter.velocity.y)

	if frame >= fighter.knockback.hitstun:
		next("AIR")
