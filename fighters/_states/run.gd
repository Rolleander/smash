class_name RUN extends GroundState

const MIN_W = 0.5
const BRAKE_WAIT = 3 # frames to wait without input before braking

var brake_f = 0
var dust = preload("res://effects/run_dust.tscn")

func enter(previous_state_path: String):
	pass

func update(_delta: float) -> void:
	super.update(_delta)
	fighter.animation("WALK")
	Sounds.playFootSteps(fighter, frame, 7)
	if frame % 4 == 0:
		fighter.veffect(dust.instantiate(), Vector2(fighter.velocity.x * -0.03 + randf_range(-10, 10)
			+ (-10 if fighter.facingRight else 10), 35))
	if CInput.justPressed(fighter, CInput.CTRL.ATTACK):
		fighter.moves.do_move(Moves.TYPE.DASH)
		return
	if CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("JUMP_SQUAT")
	if CInput.pressed(fighter, CInput.CTRL.SHIELD):
		return next("SHIELD")
	if CInput.pressed(fighter, CInput.CTRL.LEFT, MIN_W):
		if fighter.velocity.x > 0:
			return next("TURN")
		fighter.velocity.x = - fighter.atts.runSpeed
		fighter.turn(true)
		brake_f = 0
	elif CInput.pressed(fighter, CInput.CTRL.RIGHT, MIN_W):
		if fighter.velocity.x < 0:
			return next("TURN")
		fighter.velocity.x = fighter.atts.runSpeed
		fighter.turn(false)
		brake_f = 0
	elif brake_f >= BRAKE_WAIT:
		next("BRAKE")
	else:
		brake_f += 1
