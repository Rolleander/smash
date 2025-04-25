class_name SPAWN extends State

var sound = preload("res://sounds/fx/Sandy.wav")

func enter(previous_state_path: String):
	Sounds.play(sound, fighter.global_position)
	fighter.sprite.visible = true
	fighter.alive = true
	fighter.hideCamera = false
	fighter.rotation = 0
	fighter.global_position = Vector2(0, 0)
	fighter.tumbleSmoke.emitting = false


func update(_delta: float):
	if frame == 60:
		next("AIR")
		fighter.collision.set_deferred("disabled", false)
		fighter.tumbleCollision.set_deferred("disabled", true)
