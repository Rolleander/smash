@tool
class_name CircleHitboxTemplate extends HitboxTemplate

@export var radius: float = 10:
	set(value):
		if $CollisionShape2D:
			$CollisionShape2D.shape.radius = value
		radius = value
