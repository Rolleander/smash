class_name ROLL extends GroundState

func enter(previous_state_path: String):
	fighter.animation("ROLL",true)
	
func exit() -> void:
	fighter.turn( fighter.facingRight)

	
func update(_delta: float) -> void:
	super.update(_delta)
	fighter.dampenHorizontalMovement()
	fighter.velocity.x = get_roll_velocity()
	fighter.intangible(frame >= 4 && frame <= fighter.atts.rollFrames)
	if !fighter.animations.is_playing() && frame > fighter.atts.rollFrames:
		next("STAND")	

func get_roll_velocity() -> float:
	if frame < 0 or frame >= fighter.atts.rollFrames:
		return 0.0
	var t = float(frame) / float(fighter.atts.rollFrames - 1)
	var velocity_factor = sin(t * PI)	
	return velocity_factor * fighter.atts.rollSpeed * fighter.direction() 
