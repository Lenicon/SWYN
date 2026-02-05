extends Node

enum MAP {
	GRASSY,
	CAVE,
	MOON,
	HELL,
	HEAVEN
}

enum WEAPON {
	NONE,
	CANNON,
	BOMB,
	FIRE
}

var save:Dictionary = {
	"health":100,
	"jumps":2,
	"truffles":0,
	"deaths":0,
	"map":MAP.GRASSY,
	"syn":{
		"active":false,
		"weapon":WEAPON.CANNON
	}
}
