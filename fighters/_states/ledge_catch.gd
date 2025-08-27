class_name LEDGE_CATCH extends State

func enter(previous_state_path: String):
	fighter.animation("LEDGE_HOLD", true)
	fighter.fastFall = false
	fighter.on_ledge_catch.emit()

func update(_delta: float):
	super.update(_delta)
	if frame > 7:
		fighter.lagFrames = 0
		fighter.airJumps = 0
		next("LEDGE_HOLD")
