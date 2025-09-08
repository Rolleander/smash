class_name Shield extends Node2D

const depletion = 0.0625
const regeneration = 0.1
const maxHp = 50


@export var fighter: Fighter

var active = false
var hp = maxHp

func _ready() -> void:
	visible = false

func activate(active: bool):
	visible = active
	self.active = active

func hit(damage: float):
	if active:
		hp -= damage * 0.7

func breakShield():
	#todo tumble up
	activate(false)
	hp = maxHp * 0.5
	pass

func _physics_process(_delta: float) -> void:
	if active:
		hp -= depletion
		if hp <= 0:
			breakShield()
	else:
		hp += regeneration
		hp = min(hp, maxHp)
