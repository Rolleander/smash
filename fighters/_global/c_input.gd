extends Node

const CTRL = {
	LEFT = "left",
	RIGHT = "right",
	UP = "up",
	DOWN = "down",
	JUMP = "jump",
	ATTACK = "attack",
	SPECIAL = "special",
	SHIELD = "shield"
}

const AXIS = {
	X = ["left", "right"],
	Y = ["up", "down"]
}

func value(fighter: Fighter, ctrl: String):
	return Input.get_action_strength(str(fighter.controllerId) + "_" + ctrl)

func pressed(fighter: Fighter, ctrl: String, min: float = 0.8):
	return value(fighter, ctrl) >= min

func justReleased(fighter: Fighter, ctrl: String):
	return Input.is_action_just_released(str(fighter.controllerId) + "_" + ctrl)

func justPressed(fighter: Fighter, ctrl: String):
	return Input.is_action_just_pressed(str(fighter.controllerId) + "_" + ctrl)

func axis(fighter: Fighter, axis: Array):
	return Input.get_axis(str(fighter.controllerId) + "_" + axis[0], str(fighter.controllerId) + "_" + axis[1])

func angle(fighter: Fighter):
	var x = axis(fighter, AXIS.X)
	var y = axis(fighter, AXIS.Y)
	if x == 0 and y == 0:
		return null
	return atan2(y, x)
