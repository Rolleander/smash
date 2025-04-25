class_name TumbleSmoke extends Node2D

@onready var white = $"1"
@onready var gray = $"2"
@onready var black = $"3"

func _ready() -> void:
	stop()

func stop():
	white.emitting = false
	gray.emitting = false
	black.emitting = false

func start(power):
	white.emitting = true
	gray.emitting = power >= 0.5
	black.emitting = power >= 1
	print("smoke-power ",power)
