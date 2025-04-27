class_name ATTACK extends AirbornState

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
	var dampen = fighter.atts.traction * 10
	if fighter.action == Type.DASH:
		dampen = fighter.atts.traction * 3
	fighter.dampenHorizontalMovement(dampen)

func update(_delta: float) -> void:
	super.update(_delta)
	
	# sliding into air
	if not fighter.rcGroundL.is_colliding() and not fighter.rcGroundR.is_colliding():
		air_movement(false, 0, 0.5)
		
	if !fighter.animations.is_playing():
		next("STAND")	
