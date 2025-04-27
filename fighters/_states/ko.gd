class_name KO extends State

func enter(previous_state_path: String):
	fighter.alive = false
	fighter.sprite.visible = false
	fighter.velocity = Vector2(0, 0)

func update(_delta: float):
	super.update(_delta)
	if frame == 30:
		fighter.hideCamera = true
	if frame == 60 * 3:
		next("SPAWN")
