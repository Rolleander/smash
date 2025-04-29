class_name CROUCH extends State


func enter(previous_state_path: String):
	fighter.animation("CROUCH", true)
	enableCrouchHurtbox(true)
	
func exit() -> void:
	enableCrouchHurtbox(false)

func enableCrouchHurtbox(enable : bool):
	var normal = fighter.hurtBox.get_child(0) as CollisionShape2D
	var crouch = fighter.hurtBox.get_child(1) as CollisionShape2D
	normal.disabled = enable
	crouch.disabled = !enable
	
func update(_delta: float) -> void:
	super.update(_delta)
	fighter.dampenHorizontalMovement()
	if CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("JUMP_SQUAT")
	if !CInput.pressed(fighter, CInput.CTRL.DOWN) and frame >= 10:
		next("STAND")
