class_name BRAKE extends State

var sound = preload("res://sounds/fx/Slide.wav")

func enter(previous_state_path: String):
	Sounds.play(sound, fighter.global_position)

func update(_delta: float) -> void:	
	fighter.dampenHorizontalMovement()
	if fighter.velocity.x == 0:
		next("STAND")
