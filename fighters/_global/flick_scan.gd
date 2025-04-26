class_name FlickScan extends Node

enum DIR {
	UP,
	LEFT,
	RIGHT,
	DOWN
}

var _fighter : Fighter
var _window = 0
var _flicked = null
var _attackPressed = false
var _frame = 0
var _moveStart = 0
var _zeroed = false

const FLICK_V = 0.9
const DEADZONE = 0.4

func _init(fighter : Fighter,  window : int) -> void:
	self._fighter = fighter
	self._window = window	
	
func update():
	var valueX= CInput.axis(_fighter, CInput.AXIS.X)
	var valueY= CInput.axis(_fighter, CInput.AXIS.Y)
	if abs(valueX) <= DEADZONE && abs(valueY) <= DEADZONE:
		_zeroed = true
	elif _zeroed and _moveStart == 0:
		_moveStart =_frame	 
	if CInput.justPressed(_fighter, CInput.CTRL.ATTACK):
		_attackPressed = true		
	if _zeroed:
		if valueX >= FLICK_V:
			_flicked = DIR.RIGHT
		if valueX <= FLICK_V * -1:
			_flicked = DIR.LEFT
		if valueY >= FLICK_V:
			_flicked = DIR.DOWN
		if valueY <= FLICK_V * -1:
			_flicked = DIR.UP	
	_frame +=1	
	if _frame > _end_frame():
		_reset()

func _reset():
		_attackPressed = false
		_frame = 0
		_flicked = null
		_zeroed = false
		_moveStart = 0

func _end_frame():
	return _window + _moveStart

func _complete():
	return _frame == _end_frame()

func flicked():
	if !_complete():
		return null
	return _flicked 
	
func wantsAttack():
	return _attackPressed

func noFlick():
	return _complete() && _flicked == null
