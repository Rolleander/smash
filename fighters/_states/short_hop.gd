class_name SHORT_HOP extends State

func update(_delta: float) -> void:
	fighter.velocity.y = - fighter.atts.lowJumpForce
	next("AIR")
