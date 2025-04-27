class_name LANDING extends State

var sound = preload("res://sounds/fx/Powp.wav")
var dustEffect = preload("res://effects/jump.tscn")

func update(_delta: float) -> void:
	super.update(_delta)
	if frame <= fighter.atts.landingFrames + fighter.lagFrames:
		if frame == 1:
			pass
		fighter.dampenHorizontalMovement(fighter.atts.traction / 2)
		if CInput.justPressed(fighter, CInput.CTRL.JUMP):
			return next("JUMP_SQUAT")
	else:
		fighter.lagFrames = 0
		if CInput.pressed(fighter, CInput.CTRL.DOWN):
			next("CROUCH")
		else:
			next("STAND")

func enter(previous_state_path: String):
	fighter.fastFall = false
	fighter.airJumps = 0
	fighter.animation("JUMP", true)
	fighter.enablePlatformCollision(true)
	var dust = dustEffect.instantiate()
	var dropDistance = fighter.global_position.y - fighter.dropFromY
	if dropDistance < 30:
		return
	dropDistance = clamp(dropDistance, 0, 1000)
	Sounds.play(sound, fighter.global_position, -8 + dropDistance * 0.025, 1.3)
	dust.intensity = 0.6 + dropDistance * 0.003
	fighter.veffect(dust, Vector2(0, 40))
