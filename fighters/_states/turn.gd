class_name TURN extends State

var sound = preload("res://sounds/fx/Slide.wav")

func enter(previous_state_path: String):
	Sounds.play(sound, fighter.global_position)

func update(_delta: float) -> void:
	if CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("JUMP_SQUAT")
	if fighter.velocity.x > 0:
		fighter.turn(true)
		fighter.velocity.x -= fighter.atts.traction
		fighter.velocity.x = clamp(fighter.velocity.x, 0, fighter.velocity.x)
	elif fighter.velocity.x < 0:
		fighter.turn(false)
		fighter.velocity.x += fighter.atts.traction
		fighter.velocity.x = clamp(fighter.velocity.x, fighter.velocity.x, 0)
	else:
		if CInput.pressed(fighter, CInput.CTRL.LEFT) or CInput.pressed(fighter, CInput.CTRL.RIGHT):
			next("RUN")
		else:
			next("STAND")
