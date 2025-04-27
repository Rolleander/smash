class_name LEDGE_JUMP extends State

const jumpSpeed = 20
var dustEffect = preload("res://effects/jump.tscn")
var jumpSound = preload("res://sounds/fx/Jump.wav")

func enter(previous_state_path: String):
	pass

func update(_delta: float):
	super.update(_delta)
	if frame == 5:
		fighter.position.y -= jumpSpeed
		if fighter.grabbingLedge:
			fighter.grabbingLedge.grabbedBy = null
		fighter.grabbingLedge = null
		fighter.regrabPause = 0
		fighter.enablePlatformCollision(false)
		fighter.velocity.x = lerp(fighter.velocity.x, 0.0, 0.08)
		fighter.veffect(dustEffect.instantiate(), Vector2(0, 30))
		Sounds.play(jumpSound, fighter.global_position)
		next("FULL_HOP")
