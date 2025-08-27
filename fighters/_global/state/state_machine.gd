class_name StateMachine extends Node

@export var initial_state: State = null
@export var fighter: Fighter

@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
).call()

var next_state: State = null
var _force_set = false

func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)
		state_node.fighter = fighter
		state_node.ready()
	await fighter.ready
	state.enter("")
	fighter.state = state.name

func _physics_process(delta: float) -> void:
	if fighter.freeze.duration > 0:
		fighter.freeze.update()
		return
	if fighter.isLanding():
		_transition_to_next_state("LANDING")
	elif fighter.isStartingToFall():
		_transition_to_next_state("AIR")
	elif fighter.isGrounded():
		fighter.applySlopeVerticalSpeed()
	else:
		var ledge = fighter.shouldGrabLedge()
		if ledge:
			ledge.doGrab(fighter)
			_transition_to_next_state("LEDGE_CATCH")
	if fighter.regrabPause > 0:
		fighter.regrabPause -= 1
		
	fighter.flickScan.update()
	if next_state:
		var previous_state_path := state.name
		state = next_state
		next_state = null
		state.frame = 0
		state.delta = delta
		state.enter(previous_state_path)
		fighter.state = state.name
		_force_set = false
	state.delta = delta
	state.update(delta)
	fighter.move_and_slide()
	state.frame += 1


func force_state(state: String):
	next_state = get_node(state)
	_force_set = true

func next(state: String):
	_transition_to_next_state(state)

func _transition_to_next_state(target_state_path: String) -> void:
	if _force_set:
		return
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return
	state.exit()
	next_state = get_node(target_state_path)
