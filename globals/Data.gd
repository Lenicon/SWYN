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
	"health":3,
	"jumps":2,
	"truffles":0,
	"deaths":0,
	"part":1,
	"map":MAP.GRASSY,
	"syn":{
		"active":false,
		"weapon":WEAPON.CANNON
	},
	"flags":{
		"finished_main_menu":false,
		"part1_amy_steak":false,
		"part2_boss_enzo_1":false,
		"part2_stage2_intro":false,
	}
}

func check_flag(flag:String, part:int = 0)->bool:
	return Data.save["flags"][(("part"+str(part)+"_") if part!=0 else "")+flag]

func set_flag(flag:String, part:int = 0, trueorfalse:bool = true)->void:
	Data.save["flags"][(("part"+str(part)+"_") if part!=0 else "")+flag] = trueorfalse
