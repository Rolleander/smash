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
    TYPE.NONE: {"air": false, "special": false},
    TYPE.NORMAL: {"air": false, "special": false},
    TYPE.DASH: {"air": false, "special": false},
    TYPE.F_TILT: {"air": false, "special": false},
    TYPE.U_TILT: {"air": false, "special": false},
    TYPE.D_TILT: {"air": false, "special": false},
    TYPE.F_SMASH: {"air": false, "special": false},
    TYPE.U_SMASH: {"air": false, "special": false},
    TYPE.D_SMASH: {"air": false, "special": false},
    TYPE.NORMAL_AIR: {"air": true, "special": false},
    TYPE.F_AIR: {"air": true, "special": false},
    TYPE.U_AIR: {"air": true, "special": false},
    TYPE.D_AIR: {"air": true, "special": false},
    TYPE.B_AIR: {"air": true, "special": false},
    TYPE.SPECIAL: {"air": false, "special": true},
    TYPE.F_SPECIAL: {"air": false, "special": true},
    TYPE.U_SPECIAL: {"air": false, "special": true},
    TYPE.D_SPECIAL: {"air": false, "special": true},
}
