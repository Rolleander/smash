class_name Stage extends Node

var koVF = preload("res://effects/ko.tscn")

func _ready() -> void:
	var id = 0
	for fighter in StageUtils.getFighters():
		fighter.controllerId = id
		id += 1

	
func _on_blastzone_body_entered(node: Node2D) -> void:
	if node is Fighter:
		var fighter = node as Fighter
		var effect = koVF.instantiate()
		effect.global_position = fighter.global_position
		effect.rotation = fighter.velocity.angle() + PI
		effect.position -= Vector2.from_angle(effect.rotation) * 50
		effect.rotation -= PI / 2
		get_tree().get_first_node_in_group("veffects_node").add_child(effect)
		fighter.stateMachine.force_state("KO")
