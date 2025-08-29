extends FighterMove

@onready var chain = $Chain
@onready var hook = $Hook

var angle = 0
const hook_shot_speed = 16
const hook_pull_speed = 14
var hook_hit = false
var hook_miss = false

func _ready() -> void:
	super ()
	auto_complete = false
	MoveUtils.registerRescueMoveRestriction(self)
	hook.visible = false
	chain.visible = false
	hook.monitoring = false

func start():
	hook_hit = false
	hook_miss = false
	super ()

func completed():
	super ()
	hook.visible = false
	chain.visible = false
	hook.monitoring = false

func _update(frame: int):
	fighter.velocity.y = 0
	fighter.velocity.x = 0
	if frame == 20:
		angle = CInput.angle(fighter)
		if angle == null:
			running = false
			allowed = true
			return
		hook.global_position.x = fighter.global_position.x
		hook.global_position.y = fighter.global_position.y
		hook.visible = true
		chain.visible = true
		allowed = true
		hook.monitoring = true
	if hook_hit || hook_miss:
		_pull()
	elif frame > 25:
		_shoot()
	if frame == 40 and !hook_hit:
		#max range reached
		hook_miss = true
		hook.monitoring = false
	chain.points[0].x = fighter.global_position.x
	chain.points[0].y = fighter.global_position.y
	chain.points[1].x = hook.global_position.x
	chain.points[1].y = hook.global_position.y
	
func _shoot():
	hook.global_position.x += cos(angle) * hook_shot_speed
	hook.global_position.y += sin(angle) * hook_shot_speed

func _pull():
	fighter.global_position = fighter.global_position.move_toward(hook.global_position, hook_pull_speed)
	if fighter.global_position.distance_to(hook.global_position) <= 25:
		completed()
		return


func _on_hook_body_entered(_body: Node2D) -> void:
	if _body != fighter:
		hook_hit = true
		hook.monitoring = false
