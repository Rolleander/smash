@tool
class_name HitboxTemplate extends Area2D

@export var shape: CollisionShape2D
@export var atts: HitboxAttributes
@export var active: bool = false:
	set(value):
		if Engine.is_editor_hint():
			visible = value
			return
		active = value
		if active:
			spawn()
		else:
			despawn()
			
var spawned: Hitbox = null

func _ready() -> void:
	if Engine.is_editor_hint():
		visible = false

func spawn():
	var source = owner.owner as Fighter
	var hitbox = Hitbox.new(source, atts)
	var hShape = shape.duplicate()
	hitbox.add_child(hShape)
	if source.facingRight:
		hShape.position = position
	else:
		hShape.position = Vector2(-position.x, position.y)
	source.add_child(hitbox)
	spawned = hitbox

func despawn():
	if spawned:
		spawned.queue_free()
		spawned = null
