class_name TUMBLE extends AIR

var rotateSpeed = 0.0

func enter(previous_state_path: String):
	fighter.dropFromY = fighter.global_position.y
	fighter.enablePlatformCollision(false)
	fighter.collision.set_deferred("disabled", true)
	fighter.tumbleCollision.set_deferred("disabled", false)
	fighter.tumbleSmoke.amount = min(200, round(fighter.knockback.knockback * 3))
	fighter.tumbleSmoke.emitting = true
	fighter.fastFall = false
	var rotateRight = fighter.velocity.x > 0
	rotateSpeed = min(fighter.knockback.knockback * 1.5, 30)
	if !rotateRight:
		rotateSpeed *= -1
	print("enter tumble ", rotateSpeed)
	fighter.animation("TUMBLE", true)

func exit() -> void:
	fighter.knockback.reset()
	fighter.collision.set_deferred("disabled", false)
	fighter.tumbleCollision.set_deferred("disabled", true)
	fighter.tumbleSmoke.emitting = false

func endTumble():
	fighter.rotation = 0
	next("LANDING")

func reduceRotation():
	pass
	#rotateSpeed *= 0.5
	#if abs(rotateSpeed) < 0.5:
		#rotateSpeed = 0

func update(delta: float):
	fighter.rotation += rotateSpeed * delta
	if frame < fighter.knockback.hitstun:
		if fighter.surfaceBounce(delta, 0.8):
			reduceRotation()
		air_movement(false, 0)
		return

	if fighter.surfaceBounce(delta, 0.6):
		reduceRotation()
	air_movement(false, 0.5)
	if fighter.velocity.length() <= fighter.atts.fallAcceleration * 4:
		endTumble()
