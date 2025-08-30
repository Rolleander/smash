@tool
class_name HitboxTemplate extends Area2D

@export var shape: CollisionShape2D
@export var arrow: Sprite2D
@export var atts: HitboxAttributes
@export_range(0.0, 360.0, 1.0, "degrees") var angle = 0:
	set(value):
		if Engine.is_editor_hint():
			arrow.rotation = deg_to_rad(value)
		angle = value
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
	var source = FighterUtils.parent_fighter(self)
	var hitbox = Hitbox.new(source, atts, angle)
	var hShape = shape.duplicate()
	hitbox.add_child(hShape)
	if source.facingRight:
		hShape.position = position
	else:
		hitbox.angle = 180 - angle
		hShape.position = Vector2(-position.x, position.y)
	print("spawn  ", atts.posRef)
	if atts.posRef == HitboxAttributes.PosRef.STAGE:
		#doenst work yet somehow
		get_tree().get_first_node_in_group("hitboxes_node").add_child(hitbox)
	elif atts.posRef == HitboxAttributes.PosRef.PLAYER:
		source.add_child(hitbox)
	elif atts.posRef == HitboxAttributes.PosRef.LOCAL:
		get_parent().add_child(hitbox)
	spawned = hitbox

func despawn():
	if spawned:
		spawned.queue_free()
		spawned = null
