class_name Hitbox extends Area2D

var atts: HitboxAttributes
var angle = 0
var source: Fighter
var frame = 0
var hitList = []
var sourceState: String

var angleEffect = preload("res://effects/angle_indicator.tscn")

func _init(source: Fighter, atts: HitboxAttributes, angle: float) -> void:
	self.source = source
	self.atts = atts
	self.angle = angle
	self.sourceState = source.state
	self.body_entered.connect(_hit)
	
func _physics_process(delta: float) -> void:
	if !atts.detached && source.state != sourceState:
		queue_free()
	frame += 1

func _hit(body: Node2D):
	if body is Fighter:
		var fighter = body as Fighter
		if fighter == source || hitList.has(fighter):
			return
		hitList.append(fighter)
		_fighter_hit(fighter)

func _fighter_hit(fighter: Fighter):
	source.freeze.applyToSource(atts)
	if fighter.invincible:
		return
	fighter.percentage += atts.damage
	var angle = fighter.knockback.apply(angle, atts, source)
	fighter.freeze.applyToTarget(atts)
	var effect = angleEffect.instantiate()
	var hitboxPos = get_child(0).global_position
	effect.global_position = fighter.global_position.lerp(hitboxPos, 0.5)
	effect.rotation = deg_to_rad(angle - 90)
	var scale = clamp(fighter.knockback.knockback * 0.01, 0.5, 1)
	effect.scale = Vector2(scale, scale) 
	get_tree().get_first_node_in_group("veffects_node").add_child(effect)
	
	
