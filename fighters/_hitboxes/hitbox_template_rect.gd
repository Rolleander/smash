@tool
class_name RectHitboxTemplate extends HitboxTemplate

@export var width : float = 10 :
	set(value):			
		if $CollisionShape2D:	 
			$CollisionShape2D.shape.size.x = value	
		width = value
@export var height : float = 10 :
	set(value): 
		if $CollisionShape2D:
			$CollisionShape2D.shape.size.y = value	
		height = value
