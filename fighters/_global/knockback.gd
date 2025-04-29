class_name FighterKnockback

var hdecay = 0
var vdecay = 0
var knockback = 0
var hitstun = 0
var fighter: Fighter

const RATIO = 1.0
const LAUNCH_V = 30
const DECAY = 0.051

func _init(fighter : Fighter) -> void:
	self.fighter = fighter
	
func reset():
	knockback = 0
	hitstun = 0

func apply(angle: float, box: HitboxAttributes, from: Fighter):
	var power = _calc_knockback(fighter, box.damage, box.knockbackGrowth, box.knockbackBase)
	print("power ", power)
	angle = _calc_angle(angle, box.angleCalc, from)
	print("angle ", angle)
	_throw(
		_calc_horizontal_velocity(power, angle),
		_calc_vertical_velocity(power, angle),
		_calc_horizontal_decay(angle),
		_calc_vertical_decay(angle)
	)
	hitstun = _calc_hitstun(power)
	print("hitstun ", hitstun)
	knockback = power
	if power >= 20:
		fighter.stateMachine._transition_to_next_state("TUMBLE")
	else:
		fighter.stateMachine._transition_to_next_state("HITSTUN")
	fighter.freeze.applyToTarget(box)
	from.freeze.applyToSource(box)
	return angle
	

func _calc_angle(angle: float, calc: HitboxAttributes.AngleCalc, source: Fighter):
	match calc:
		HitboxAttributes.AngleCalc.SET:
			return angle
		HitboxAttributes.AngleCalc.PUSH_AWAY:
			return rad_to_deg((fighter.global_position - source.global_position).angle())
		HitboxAttributes.AngleCalc.PULL_INWARDS:
			return rad_to_deg((source.global_position - fighter.global_position).angle())
		
func _calc_knockback(fighter : Fighter, damage, knockbackGrowth, knockbackBase):
	var p = fighter.percentage + damage
	var d = damage
	var w = fighter.atts.weight
	var s = knockbackGrowth / 100.0
	var b = knockbackBase
	var r = RATIO
	if fighter.state == "CROUCH":
		r = 0.65
	#melee onward formula
	return (((((p / 10.0) + ((p * d) / 20.0)) * (200.0 / (w + 100.0) * 1.4) + 18.0) * s) + b) * r


func _throw(hVelocity, vVelocity, hDecay, vDecay):
	fighter.velocity.x = hVelocity
	fighter.velocity.y = vVelocity
	self.hdecay = hDecay
	self.vdecay = vDecay
	print("throw ", hVelocity, " - ", vVelocity, "   ", hdecay, " - ", vDecay)


func _calc_hitstun(power):
	return floor(power * 0.4)

func _calc_horizontal_decay(angle):
	var decay = DECAY * cos(deg_to_rad(angle))
	return abs(_round_up(decay) * 1000)

func _calc_vertical_decay(angle):
	var decay = DECAY * sin(deg_to_rad(angle))
	return abs(_round_up(decay) * 1000)

func _calc_horizontal_velocity(power, angle):
	return _round_up(power * LAUNCH_V * cos(deg_to_rad(angle)))

func _calc_vertical_velocity(power, angle):
	return _round_up(power * LAUNCH_V * sin(deg_to_rad(angle)))

func _round_up(a):
	return round(a)
