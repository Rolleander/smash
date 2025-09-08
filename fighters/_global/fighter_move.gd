class_name FighterMove
extends Node2D

enum MoveProtection {
	NONE,
	ARMOR,
	INVINCIBLE,
	INTANGIBLE,
}

@export var type = Moves.TYPE.NONE
@export var chargeable = false
@export var charge_animation: String
@export var charge_length = 60
@export var charge_powerup = 1.4
@export var protection = MoveProtection.NONE
@export var protectionLimit = 0

@onready var fighter = get_parent().get_parent() as Fighter

var animation: String
var _charging = false
var _charge_frames = 0
var _special = false
var _charged_powerup = 1
var running = false
var _move_frame = 0
var allowed = true
var auto_complete = true

func _ready() -> void:
	_special = Moves.FLAGS[type]["special"] as bool
	animation = Moves.TYPE.keys()[type]
	visible = false

signal on_start()

func start():
	_charge_frames = 0
	running = true
	on_start.emit()
	if chargeable:
		var charge_anim = charge_animation if charge_animation else animation + "_CHARGE"
		fighter.animation(charge_anim, true)
	else:
		fighter.animation(animation, true)
		visible = true
	_move_frame = 0
	_charging = chargeable

func completed():
	running = false
	pass

func _update(frame: int):
	pass

func update_move(_delta: float) -> bool:
	if _charging:
		if (_special and !CInput.pressed(fighter, CInput.CTRL.SPECIAL)) or (!_special and !CInput.pressed(fighter, CInput.CTRL.ATTACK)):
			_release_charge()
		_charge_frames += 1
	elif running:
		if auto_complete && !fighter.animations.is_playing():
			completed()
		_update(_move_frame)
		_move_frame += 1
	return running

func _release_charge():
	var charge_fraction = clamp(_charge_frames * 1.0 / charge_length, 0, 1)
	_charged_powerup = lerp(1.0, charge_powerup, charge_fraction)
	fighter.animation(animation, true)
	_charging = false
	visible = true
