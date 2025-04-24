class_name State extends Node

var fighter : Fighter
var frame = 0

signal finished(next : String)

func ready():
	pass
	
func update(_delta: float):
	pass

func enter(previous_state_path: String) -> void:
	pass

func exit() -> void:
	pass

func next(state: String):
	finished.emit(state)
