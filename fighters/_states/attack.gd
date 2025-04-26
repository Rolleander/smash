class_name ATTACK extends State

enum Type {
	NORMAL,
	DASH,
	F_TILT,
	U_TILT,
	D_TILT,
	F_SMASH,
	U_SMASH,
	D_SMASH	
}

func enter(previous_state_path: String):
	print("action => ", Type.keys()[fighter.action])
	if CInput.pressed(fighter, CInput.CTRL.UP):
		fighter.animation("ATTACK_UP", true)	
	else:
		fighter.animation("ATTACK", true)
	fighter.dampenHorizontalMovement()

func update(_delta: float) -> void:
	if !fighter.animations.is_playing():
		next("STAND")	
