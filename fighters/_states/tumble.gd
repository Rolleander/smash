class_name TUMBLE extends AirbornState

var rotateSpeed = 0.0
const fallSlowdown = 0.5

func enter(previous_state_path: String):
	fighter.dropFromY = fighter.global_position.y
	fighter.enablePlatformCollision(false)
	fighter.collision.set_deferred("disabled", true)
	fighter.tumbleCollision.set_deferred("disabled", false)
	fighter.tumbleSmoke.start((fighter.knockback.knockback - 20) * 0.035)
	fighter.fastFall = false
	var rotateRight = fighter.velocity.x > 0
	rotateSpeed = min(fighter.knockback.knockback * 1.5, 30)
	if !rotateRight:
		rotateSpeed *= -1
	print("enter tumble ", rotateSpeed)
	fighter.animation("TUMBLE", true)

func exit() -> void:
	fighter.collision.set_deferred("disabled", false)
	fighter.tumbleCollision.set_deferred("disabled", true)
	fighter.tumbleSmoke.stop()

func endTumble():
	fighter.rotation = 0
	next("LANDING")

func _flipRotation():
	rotateSpeed *= -0.6	

func update(delta: float):
	super.update(delta)
	fighter.rotation += rotateSpeed * delta
	if frame < fighter.knockback.hitstun:
		if Collision.checkSurfaceBounce(fighter, delta, 0.8) == Collision.BounceResult.BOUNCE:
			_flipRotation()
		air_movement(false, 0, fallSlowdown)
		return
	
	var bounce = Collision.checkSurfaceBounce(fighter, delta, 0.6)
	if bounce == Collision.BounceResult.BOUNCE:
		_flipRotation()
	if (bounce == Collision.BounceResult.SLIDE or bounce == Collision.BounceResult.BOUNCE) and abs(fighter.velocity.y) <= 300:
		endTumble()
		return
		
	air_movement(false, 0.5, fallSlowdown)
