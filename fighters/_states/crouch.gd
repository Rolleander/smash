class_name CROUCH extends State

func update(_delta: float) -> void:
	super.update(_delta)
	next("STAND")
		
