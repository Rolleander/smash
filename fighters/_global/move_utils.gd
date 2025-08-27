func registerRescueMoveRestriction(move: FighterMove):
    RescueMoveRestriction.new(move)

class RescueMoveRestriction:
    var used = false

    func _init(move: FighterMove):
        var fighter = move.fighter
        move.on_start.connect(func(): used = true)
        fighter.on_landing.connect(_reset)
        fighter.on_spawn.connect(_reset)
        fighter.on_ledge_catch.connect(_reset)

    func _reset():
        used = false

    func _allowed():
        return !used