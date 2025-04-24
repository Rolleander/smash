class_name DROP extends State

func enter(previous_state_path: String):
	fighter.enablePlatformCollision(false)

func update(_delta: float) -> void:
	fighter.velocity.y += fighter.atts.fallAcceleration / 2.0
	fighter.dampenHorizontalMovement()
	if frame == 7:
		next("AIR")
		fighter.enablePlatformCollision(true)
