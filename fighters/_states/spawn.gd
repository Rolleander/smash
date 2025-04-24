class_name SPAWN extends State

var sound = preload("res://sounds/fx/Sandy.wav")

func enter(previous_state_path: String):
	Sounds.play(sound, fighter.global_position)
	fighter.visible = true
	fighter.alive = true
	fighter.hideCamera = false
	fighter.position = Vector2(0, 0)

func update(_delta: float):
	if frame == 60:
		next("AIR")
