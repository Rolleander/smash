class_name Moves

enum TYPE {
	NONE,
	NORMAL,
	DASH,
	F_TILT,
	U_TILT,
	D_TILT,
	F_SMASH,
	U_SMASH,
	D_SMASH,
	NORMAL_AIR,
	F_AIR,
	U_AIR,
	D_AIR,
	B_AIR,
	SPECIAL,
	F_SPECIAL,
	U_SPECIAL,
	D_SPECIAL
}

const FLAGS = {
    TYPE.NONE: {"special": false},
    TYPE.NORMAL: {"special": false},
    TYPE.DASH: {"special": false},
    TYPE.F_TILT: {"special": false},
    TYPE.U_TILT: {"special": false},
    TYPE.D_TILT: {"special": false},
    TYPE.F_SMASH: {"special": false},
    TYPE.U_SMASH: {"special": false},
    TYPE.D_SMASH: {"special": false},
    TYPE.NORMAL_AIR: {"special": false},
    TYPE.F_AIR: {"special": false},
    TYPE.U_AIR: {"special": false},
    TYPE.D_AIR: {"special": false},
    TYPE.B_AIR: {"special": false},
    TYPE.SPECIAL: {"special": true},
    TYPE.F_SPECIAL: {"special": true},
    TYPE.U_SPECIAL: {"special": true},
    TYPE.D_SPECIAL: {"special": true},
}
