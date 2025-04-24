class_name Hitbox extends Area2D

var atts: HitboxAttributes
var source: Fighter
var frame = 0
var hitList = []
var sourceState: String

func _init(source: Fighter, atts: HitboxAttributes) -> void:
	self.source = source
	self.atts = atts
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
	fighter.percentage += atts.damage
	fighter.knockback.apply(atts)
