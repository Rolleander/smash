class_name FULL_HOP extends State

func update(_delta: float) -> void:
	super.update(_delta)
	fighter.velocity.y = - fighter.atts.highJumpForce
	next("AIR")
