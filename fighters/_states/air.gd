class_name AIR extends AirbornState

var fastFallSound = preload("res://sounds/fx/Whow.wav")

func enter(previous_state_path: String):
	fighter.dropFromY = fighter.global_position.y

func update(_delta: float) -> void:
	super.update(_delta)
	fighter.animation("AIR")
	
	if startAttack():
		return
	
	if CInput.pressed(fighter, CInput.CTRL.DOWN, 1) and fighter.velocity.y > -150 and not fighter.fastFall:
		fighter.velocity.y = fighter.atts.maxFallSpeed
		fighter.fastFall = true
		Sounds.play(fastFallSound, fighter.global_position, -2, 2)
		
	air_movement(!moveBuffering && flickScanDone)
	check_platforms()
	
	if CInput.justPressed(fighter, CInput.CTRL.JUMP) and fighter.airJumps < fighter.atts.airJumps:
		air_jump()

func check_platforms():
	if fighter.velocity.y > 0:
		fighter.enablePlatformCollision(!fighter.fastFall)
	elif fighter.velocity.y < 0:
		fighter.enablePlatformCollision(false)
