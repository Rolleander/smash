extends Node

enum BounceResult{
	NONE,
	SLIDE,
	BOUNCE
}

var _wallBounce = preload("res://effects/wall_bounce.tscn")

func checkSurfaceBounce(fighter : Fighter,  delta: float, slowDownFactor = 0.8):
	var bounce = fighter.move_and_collide(fighter.velocity * delta, true, 0.08, true)
	if bounce:
		var normal = bounce.get_normal()
		var vel_dir = fighter.velocity.normalized()
		var impact = abs(vel_dir.dot(normal))  
		# 1 = full head-on, 0 = sliding
		if impact >= 0.4 and fighter.velocity.length() >= 150:
			fighter.velocity = fighter.velocity.bounce(normal) * slowDownFactor
			fighter.knockback.hitstun = round(fighter.knockback.hitstun * slowDownFactor)
			var effect = _wallBounce.instantiate()
			effect.global_position = bounce.get_position()
			get_tree().get_first_node_in_group("veffects_node").add_child(effect)
			return BounceResult.BOUNCE
		return BounceResult.SLIDE
	return BounceResult.NONE
