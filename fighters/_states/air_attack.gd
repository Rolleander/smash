class_name AIR_ATTACK extends AirbornState

enum Type {
	NORMAL_AIR,
	F_AIR,
	U_AIR,
	D_AIR,
	B_AIR,
}

func enter(previous_state_path: String):
	print("action => ", Type.keys()[fighter.action])
	fighter.animation("ATTACK", true)
	

func update(_delta: float) -> void:
	super.update(_delta)
	air_movement(false, 0)
	if !fighter.animations.is_playing():
		next("AIR")	
