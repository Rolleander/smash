class_name BRAKE extends GroundState

var sound = preload("res://sounds/fx/Slide.wav")

func enter(previous_state_path: String):
	Sounds.play(sound, fighter.global_position)

func update(_delta: float) -> void:	
	super.update(_delta)
	fighter.dampenHorizontalMovement()
	
	if CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("JUMP_SQUAT")
		
	if CInput.pressed(fighter, CInput.CTRL.SHIELD):
		return next("SHIELD")	
	
	if startAttack(true, true):
		return
	
	if fighter.velocity.x == 0:
		next("STAND")
