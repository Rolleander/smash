class_name MoveHandler
extends RefCounted

var _next_move: Moves.TYPE = Moves.TYPE.NONE
var fighter: Fighter
var _moves = {}

signal on_move_start(type: Moves.TYPE)

func _init(fighter: Fighter) -> void:
	self.fighter = fighter

func ready():
	var moves_node = fighter.find_child('MOVES')
	for node in moves_node.get_children():
		var fighter_move = node as FighterMove
		_moves[fighter_move.type] = fighter_move

func _get_move(move: Moves.TYPE) -> FighterMove:
	return _moves.get(move, null)

func do_move(move: Moves.TYPE) -> void:
	fighter.flickScan.consumeMove()
	var fighter_move = _get_move(move)
	if not fighter_move:
		printerr("no move registerd for ", Moves.TYPE.keys()[move])
		return
	if !fighter_move.allowed:
		return
	self._next_move = move
	if fighter.isGrounded():
		fighter.stateMachine.next("ATTACK")
	else:
		fighter.stateMachine.next("AIR_ATTACK")

func pop_move() -> FighterMove:
	var move = _next_move
	if move == Moves.TYPE.NONE:
		return
	var type = Moves.TYPE.keys()[move]
	print("start _next_move => ", type)
	var fighter_move = _get_move(move)
	fighter_move.start()
	on_move_start.emit(move)
	_next_move = Moves.TYPE.NONE
	return fighter_move
