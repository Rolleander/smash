extends VEffect

@export var intensity : float

func _ready() -> void:
	var emitter = $CPUParticles2D
	emitter.emission_rect_extents.x = 20 + 10 * intensity 
	emitter.scale_amount_min = 0.4 * intensity
	emitter.scale_amount_max = 0.8 * intensity
