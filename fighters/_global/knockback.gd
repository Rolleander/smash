class_name FighterKnockback

var hdecay
var vdecay
var knockback
var hitstun
var conntected: bool
var fighter: Fighter

const ratio = 0.04

func apply(box: HitboxAttributes):
    var power = _calc_knockback(fighter.percentage, box.damage, fighter.atts.weight, box.knockbackScaling, box.knockbackBase)
    _throw(
        _calc_horizontal_velocity(power, box.angle),
        _calc_vertical_velocity(power, box.angle),
        _calc_horizontal_decay(box.angle),
        _calc_vertical_decay(box.angle)
    )
    conntected = true
    hitstun = _calc_hitstun(power)
    knockback += power
    fighter.stateMachine._transition_to_next_state("HITSTUN")


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

const angleConversion = PI / 180
const initialV = 30

func _calc_hitstun(power):
    return floor(power / 0.3 * 0.4)

func _calc_horizontal_decay(angle):
    var decay = 0.051 * cos(angle * angleConversion)
    return abs(_round_up(decay) * 1000)

func _calc_vertical_decay(angle):
    var decay = 0.051 * sin(angle * angleConversion)
    return abs(_round_up(decay) * 1000)

func _calc_horizontal_velocity(power, angle):
    var initial = power * initialV
    return _round_up(initial * cos(angle * angleConversion))

func _calc_vertical_velocity(power, angle):
    var initial = power * initialV
    return _round_up(initial * sin(angle * angleConversion))


func _round_up(a):
    return round(a * 100000) / 100000