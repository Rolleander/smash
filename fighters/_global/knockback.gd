class_name FighterKnockback

var hdecay = 0
var vdecay = 0
var knockback = 0
var hitstun = 0
var fighter: Fighter

const ratio = 0.04

func reset():
	knockback = 0
	hitstun = 0

func apply(angle: float, box: HitboxAttributes, from: Fighter):
	var power = _calc_knockback(fighter.percentage, box.damage, fighter.atts.weight, box.knockbackScaling, box.knockbackBase)
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
	if power >= 18:
		fighter.stateMachine._transition_to_next_state("TUMBLE")
	else:
		fighter.stateMachine._transition_to_next_state("HITSTUN")

func _calc_angle(angle: float, calc: HitboxAttributes.AngleCalc, source: Fighter):
	match calc:
		HitboxAttributes.AngleCalc.SET:
			return angle
		HitboxAttributes.AngleCalc.AWAY_FROM_PLAYER:
			return rad_to_deg((fighter.global_position - source.global_position).angle())
		HitboxAttributes.AngleCalc.TOWARDS_PLAYER:
			return rad_to_deg((source.global_position - fighter.global_position).angle())
		
func _calc_knockback(percentage, damage, weight, knockbackScaling, knockbackBase):
	var p = percentage
	var d = damage
	var w = weight
	var s = knockbackScaling
	var b = knockbackBase
	var r = ratio
	#melee onward formula
	return (((((p / 10.0) + ((p * d) / 20.0)) * (200.0 / (w + 100.0) * 1.4) + 18.0) * s) + b) * r


func _throw(hVelocity, vVelocity, hDecay, vDecay):
	fighter.velocity.x = hVelocity
	fighter.velocity.y = vVelocity
	self.hdecay = hDecay
	self.vdecay = vDecay
	print("throw ", hVelocity, " - ", vVelocity, "   ", hdecay, " - ", vDecay)

const initialV = 30

func _calc_hitstun(power):
	return floor(power / 0.3 * 0.4)

func _calc_horizontal_decay(angle):
	var decay = 0.051 * cos(deg_to_rad(angle))
	return abs(_round_up(decay) * 1000)

func _calc_vertical_decay(angle):
	var decay = 0.051 * sin(deg_to_rad(angle))
	return abs(_round_up(decay) * 1000)

func _calc_horizontal_velocity(power, angle):
	var initial = power * initialV
	return _round_up(initial * cos(deg_to_rad(angle)))

func _calc_vertical_velocity(power, angle):
	var initial = power * initialV
	return _round_up(initial * sin(deg_to_rad(angle)))

func _round_up(a):
	return round(a * 100000) / 100000
