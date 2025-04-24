extends Node

var foots = [preload("res://sounds/fx/Footsteps.wav"),
 preload("res://sounds/fx/Footsteps 2.wav"),
 preload("res://sounds/fx/Footsteps 3.wav"),
 preload("res://sounds/fx/Footsteps 4.wav")]

func play(stream: AudioStream, position: Vector2, db = 0.0, pitch = 1.0):
	var player = AudioStreamPlayer2D.new()
	player.stream = stream
	player.global_position = position
	player.autoplay = true
	player.volume_db = db
	player.pitch_scale = pitch
	get_tree().current_scene.add_child(player)
	player.finished.connect(func(): player.queue_free())

func playFootSteps(fighter : Fighter, frame :int, space : int):
	if frame ==0 || frame % space == 0:
		play(foots[randi_range(0,foots.size()-1)], fighter.global_position, 6- space * 0.2)
		
