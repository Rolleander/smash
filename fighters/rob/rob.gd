extends Fighter


func _physics_process(delta: float) -> void:
	super(delta)
	$Label.text = state
