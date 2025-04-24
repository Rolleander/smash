class_name JUMP_SQUAT extends State

var jumpSound = preload("res://sounds/fx/Jump.wav")
var dustEffect = preload("res://effects/jump.tscn")

func update(_delta: float) -> void:
	if frame == fighter.atts.jumpSquatFrames:
		Sounds.play(jumpSound, fighter.global_position)
		fighter.enablePlatformCollision(false)
		var dust = dustEffect.instantiate() 
		if CInput.pressed(fighter, CInput.CTRL.JUMP):
			fighter.velocity.x = lerp(fighter.velocity.x, 0.0, 0.08)
			next("FULL_HOP")
			dust.intensity = 1
		else:
			fighter.velocity.x = lerp(fighter.velocity.x, 0.0, 0.08)
			next("SHORT_HOP")
			dust.intensity = 0.7
		fighter.veffect(dust, Vector2(0, 30))


func enter(previous_state_path: String):
	fighter.animation("JUMP", true)
