class_name VEffect extends Node2D


@export var player : AnimationPlayer

func _ready() -> void:
	player.animation_finished.connect(_done)
	
func _done(anim : String):	
	queue_free()
