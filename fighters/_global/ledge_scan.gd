class_name LedgeScan extends RayCast2D

var _origin: Vector2
var _target: Vector2

func _ready() -> void:
	_origin = position
	_target = target_position
	collide_with_areas = true
	hit_from_inside = true
	
func turn(left: bool):
	var dir = -1 if left else 1
	position = Vector2(_origin.x * dir, _origin.y)
	target_position = Vector2(_target.x * dir, _target.y)
