class_name SHIELD extends GroundState

func enter(previous_state_path: String):
	fighter.shield.visible = true
	fighter.animation("SHIELD",true)
	
func exit() -> void:
	fighter.shield.visible = false
	
func update(_delta: float) -> void:
	super.update(_delta)
	fighter.dampenHorizontalMovement()
	if CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("JUMP_SQUAT")
	if CInput.justPressed(fighter, CInput.CTRL.LEFT):
		fighter.facingRight = false
		return next("ROLL")
	if CInput.justPressed(fighter, CInput.CTRL.RIGHT):
		fighter.facingRight = true
		return next("ROLL")

	if !CInput.pressed(fighter, CInput.CTRL.SHIELD) and frame >= 11:
		next("STAND")
