class_name ATTACK extends State

func enter(previous_state_path: String):
	fighter.animation("ATTACK", true)
	fighter.dampenHorizontalMovement()

func update(_delta: float) -> void:
	if !fighter.animations.is_playing():
		next("STAND")	
