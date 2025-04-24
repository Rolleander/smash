class_name Ledge extends Area2D

@export var right = true

var grabbedBy: Fighter = null
var _checkFrames = 0
var _farFighters: Array[Fighter] = []
var _audienceSound = preload("res://sounds/fx/audience/maind8.dsp.wav")
const w = 5

func canBeGrabbedBy(fighter: Fighter) -> bool:
	return grabbedBy == null && fighter.regrabPause <= 0

func doGrab(fighter: Fighter):
	fighter.velocity.x = 0
	fighter.velocity.y = 0
	fighter.global_position.y = global_position.y + 15
	fighter.global_position.x = global_position.x + (w if right else -w)
	grabbedBy = fighter
	fighter.turn(right)
	fighter.grabbingLedge = self
	if _farFighters.has(fighter):
		Sounds.play(_audienceSound, global_position, -5)
		_farFighters.erase(fighter)

func _on_body_exited(body: Node2D) -> void:
	if body == grabbedBy:
		grabbedBy.grabbingLedge = null
		grabbedBy = null

func _physics_process(delta: float) -> void:
	_checkFrames += 1
	if _checkFrames == 5:
		_checkFrames = 0
		for fighter in StageUtils.getFighters():
			if !fighter.alive || fighter.inState(["LANDING", "STAND"]) || fighter.isWalking():
				_farFighters.erase(fighter)
			if !_farFighters.has(fighter) && _is_fighter_far(fighter):
				_farFighters.append(fighter)

func _is_fighter_far(fighter: Fighter):
	var x = fighter.global_position.x
	if right && x < global_position.x:
		return false
	elif !right && x > global_position.x:
		return false
	var distance = fighter.global_position.distance_to(global_position)
	return distance > 250
