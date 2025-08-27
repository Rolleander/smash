extends Fighter

func _ready() -> void:
	super()


func _physics_process(delta: float) -> void:
	super (delta)
	$Label.text = str(percentage)
