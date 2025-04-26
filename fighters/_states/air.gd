class_name AIR extends State

var DoubleJumpVF = preload("res://effects/double_jump.tscn")
var fastFallSound = preload("res://sounds/fx/Whow.wav")

func enter(previous_state_path: String):
	fighter.dropFromY = fighter.global_position.y

func update(_delta: float) -> void:
	fighter.animation("AIR")
	if CInput.pressed(fighter, CInput.CTRL.DOWN, 1) and fighter.velocity.y > -150 and not fighter.fastFall:
		fighter.velocity.y = fighter.atts.maxFallSpeed
		fighter.fastFall = true
		Sounds.play(fastFallSound, fighter.global_position, -2, 2)
		
	air_movement()
	check_platforms()
	
	if CInput.justPressed(fighter, CInput.CTRL.JUMP) and fighter.airJumps < fighter.atts.airJumps:
		fighter.airJumps += 1
		fighter.fastFall = false
		fighter.velocity.x = 0
		fighter.velocity.y = - fighter.atts.doubleJumpForce
		fighter.veffect(DoubleJumpVF.instantiate(), Vector2(0, -30))
		if CInput.pressed(fighter, CInput.CTRL.LEFT):
			fighter.velocity.x = - fighter.atts.maxAirSpeed
		if CInput.pressed(fighter, CInput.CTRL.RIGHT):
			fighter.velocity.x = fighter.atts.maxAirSpeed

func air_movement(allowTurning = true, steerFactor = 1.0, fallFactor = 1.0):
	if fighter.velocity.y < 0:
		fighter.dropFromY = fighter.global_position.y
	if fighter.velocity.y < fighter.atts.fallSpeed:
		fighter.velocity.y += fighter.atts.fallAcceleration * fallFactor
		fighter.velocity.y = clamp(fighter.velocity.y, fighter.velocity.y, fighter.atts.fallSpeed)
	if steerFactor == 0 || !_air_steering(allowTurning, steerFactor):
		fighter.dampenHorizontalMovement(fighter.atts.airAcceleration / 5.0)

func _air_steering(allowTurning = true, factor = 1.0):
	if CInput.pressed(fighter, CInput.CTRL.LEFT) and fighter.velocity.x > fighter.atts.maxAirSpeed * -1:
		fighter.velocity.x -= fighter.atts.airAcceleration
		if allowTurning:
			fighter.turn(true)
		return true
	if CInput.pressed(fighter, CInput.CTRL.RIGHT) and fighter.velocity.x < fighter.atts.maxAirSpeed:
		fighter.velocity.x += fighter.atts.airAcceleration
		if allowTurning:
			fighter.turn(false)
		return true
	return false

func check_platforms():
	if fighter.velocity.y > 0:
		fighter.enablePlatformCollision(!fighter.fastFall)
	elif fighter.velocity.y < 0:
		fighter.enablePlatformCollision(false)
