class_name State extends Node

const TILT_LIMIT = 0.6
const TURN_LIMIT = 0.3

var fighter: Fighter
var frame = 0
var delta = 0

var stick_x = 0
var stick_y = 0
var flick = false
var noFlick = false
var moveBuffering = false
var scanFlicks = false
var flickScanDone = false

signal finished(next: String)

func ready():
	pass
	
func update(_delta: float):
	stick_x = CInput.axis(fighter, CInput.AXIS.X)
	stick_y = CInput.axis(fighter, CInput.AXIS.Y)
	flick = fighter.flickScan.flicked()
	noFlick = fighter.flickScan.noFlick()
	moveBuffering = fighter.flickScan.wantsMove()
	flickScanDone = fighter.flickScan.complete()

func enter(previous_state_path: String) -> void:
	pass

func exit() -> void:
	pass

func next(state: String):
	finished.emit(state)
