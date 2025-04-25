class_name HitboxAttributes extends Resource

enum Type {
	NORMAL
}

enum AngleCalc {
	SET,
	AWAY_FROM_PLAYER,
	TOWARDS_PLAYER
}

@export var damage = 10
@export var knockbackBase = 100
@export var knockbackScaling = 2.0
@export var hitlag = 1
@export var type = Type.NORMAL
@export var angleCalc = AngleCalc.SET
@export var detached = false
