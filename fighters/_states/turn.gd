class_name TURN extends GroundState

var sound = preload("res://sounds/fx/Slide.wav")

func enter(previous_state_path: String):
	Sounds.play(sound, fighter.global_position)

func update(_delta: float) -> void:
	super.update(_delta)
	if CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("JUMP_SQUAT")		
	if CInput.pressed(fighter, CInput.CTRL.SHIELD):
		return next("SHIELD")	
		
	if startAttack(true, true):
		return
			
	fighter.dampenHorizontalMovement()
	if fighter.velocity.x > 0:
		fighter.turn(true)
	elif fighter.velocity.x < 0:
		fighter.turn(false)
	else:
		if CInput.pressed(fighter, CInput.CTRL.LEFT) or CInput.pressed(fighter, CInput.CTRL.RIGHT):
			next("RUN")
		else:
			next("STAND")
