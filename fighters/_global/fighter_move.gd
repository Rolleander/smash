class_name FighterMove
extends Node

@export var type = Moves.TYPE.NONE
@export var chargeable = false
@export var charge_animation: String
@export var charge_length = 60
@export var charge_powerup = 1.4

@onready var fighter = get_parent().get_parent() as Fighter

var animation: String
var _charging = false
var _charge_frames = 0
var _special = false
var _charged_powerup = 1
var running = false

func _ready() -> void:
	_special = Moves.FLAGS[type]["special"] as bool
	animation = Moves.TYPE.keys()[type]

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
	_charging = chargeable

func completed():
	running = false
	pass

func forbidden():
	return false

func _physics_process(_delta: float) -> void:
	if _charging:
		if (_special and !CInput.pressed(fighter, CInput.CTRL.SPECIAL)) or (!_special and !CInput.pressed(fighter, CInput.CTRL.ATTACK)):
			_release_charge()
		_charge_frames += 1
	else:
		if running and !fighter.animations.is_playing():
			completed()

func _release_charge():
	var charge_fraction = clamp(_charge_frames * 1.0 / charge_length, 0, 1)
	_charged_powerup = lerp(1.0, charge_powerup, charge_fraction)
	fighter.animation(animation, true)
	_charging = false
