class_name InputScan extends Node

enum FlickAxis {
	X,
	Y
}

var _fighter : Fighter
var _count = 0
var _axis : FlickAxis
var _flicked = 0
var _frame = 0
var _zero_frame = null

const FLICK_V = 1.0

func _init(fighter : Fighter,  count : int, axis : FlickAxis) -> void:
	self._fighter = fighter
	self._count = count	
	self._axis = axis
	
func update():
	var value = 0
	if _axis == FlickAxis.X:
		value= CInput.axis(_fighter, CInput.AXIS.X)
	else:
		value= CInput.axis(_fighter, CInput.AXIS.Y)
	_flicked = 0
	if value == 0:
		_zero_frame = _frame
	if value == FLICK_V && _zero_frame !=null && (_frame - _zero_frame) < _count:
		_flicked = 1
		_zero_frame = null
	if value == FLICK_V * -1 && _zero_frame !=null && (_frame - _zero_frame) < _count:
		_flicked = -1
		_zero_frame = null
	_frame +=1

func _complete():
	if _zero_frame !=null:
		return _frame - _zero_frame >= _count
	return _frame >= _count

func flickedPositive():
	return _flicked == 1

func flickedNegative():
	return _flicked == -1

func noFlick():
	return _complete() && _flicked == 0
