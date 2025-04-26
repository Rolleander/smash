class_name FreezFrames 

var duration = 0
var frames = 0
var originalPos = Vector2(0,0)
var originalVel = Vector2(0,0)
var fighter : Fighter
var shaking = false

func _init(fighter : Fighter) -> void:
	self.fighter = fighter

func update():
	if shaking and (floori(duration) % 5 == 0):
		var shake_strength = min(frames * 0.15, 5)
		var offset = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * shake_strength
		fighter.sprite.position += offset				
	duration -=1			
	if duration <=0:
		_restore()
		return

func applyToSource(atts : HitboxAttributes):
	_apply(atts)
	shaking = false
	fighter.animations.pause()
	
func applyToTarget(atts : HitboxAttributes):
	_apply(atts)
	shaking = true
	fighter.animation("HITSTUN", true)
	fighter.sprite.position = Vector2(0,0)
	
func _apply(atts : HitboxAttributes):
	var length = _calc_hitlag(atts)
	duration += length
	frames = max(length, frames)
	shaking = true
	originalPos = fighter.global_position
	originalVel = fighter.velocity

func _restore():
	if shaking:
		fighter.sprite.position = Vector2(0,0)
	fighter.global_position = originalPos
	fighter.velocity = originalVel
	fighter.animations.play()
	frames = 0

func _calc_hitlag(atts : HitboxAttributes):
	return floor(atts.damage * 0.3 +4)
