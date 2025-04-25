class_name HitboxAttributes extends Resource

enum Type {
	NORMAL
}

enum AngleCalc {
	SET,
	PUSH_AWAY,
	PULL_INWARDS
}

@export var damage = 3
@export var knockbackBase = 20
@export var knockbackGrowth = 60
@export var hitlag = 1
@export var type = Type.NORMAL
@export var angleCalc = AngleCalc.SET
@export var detached = false
