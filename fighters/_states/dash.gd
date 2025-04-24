class_name DASH extends State

var sound = preload("res://sounds/fx/Swiff.wav")
var dustEffect = preload("res://effects/dash_dust.tscn")

const rcPlus = 5
var rcLengthR = 0
var rcLengthL = 0

func ready() -> void:
	rcLengthL = fighter.rcGroundL.target_position.y
	rcLengthR = fighter.rcGroundR.target_position.y

func enter(previous_state_path: String):
	Sounds.play(sound, fighter.global_position)
	var effect = dustEffect.instantiate()
	if fighter.facingRight:
		effect.player.play("left")
	else:
		effect.player.play("right")
	fighter.veffect(effect, Vector2(0, 30))
	if fighter.facingRight:
		effect.position.x -= 30
		fighter.rotation = PI * 0.2
	else:
		#effect.position.x -= 30
		fighter.rotation = - PI * 0.2
	fighter.animation("DASH")
	fighter.velocity.y = 0

func update(_delta: float) -> void:
	if fighter.facingRight:
		fighter.rcGroundR.target_position.y = rcLengthR + rcPlus
		fighter.rcGroundL.target_position.y = rcLengthL
	else:
		fighter.rcGroundL.target_position.y = rcLengthL + rcPlus
		fighter.rcGroundR.target_position.y = rcLengthR

	if CInput.justPressed(fighter, CInput.CTRL.JUMP):
		return next("JUMP_SQUAT")

	if frame >= fighter.atts.dashFrames - 1:
		return next("RUN")

func exit() -> void:
	fighter.rotation = 0
	fighter.rcGroundL.target_position.y = rcLengthL
	fighter.rcGroundR.target_position.y = rcLengthR
