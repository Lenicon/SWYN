extends Node

enum SYN_STATUS {
	NONE,
	NOWEAPON,
	CANNON,
	#BOMB,
	#FIRE
}

var save:Dictionary = {
	"health":3,
	"jumps":2,
	"room": "",
	"total_deaths": 0,
	"death_reason":"",
	"syn": SYN_STATUS.NONE,
	"flags":{
		0:{
			"finished_main_menu":false,
		},
		1:{
			"truffles": 0,
			"deaths": -1,
			"amy_steak":false,
		},
		2:{
			"boss_enzo_deaths":-1,
			"boss_enzo_beaten":false,
			"stage2_intro":false,
		},
	}
}



# HELPER FUNCTIONS
func get_flag(flag:String, part:int = 0)->Variant:
	if !Data.save["flags"][part].has(flag): 
		printerr('"'+flag+'"' + " does not exist in part "+str(part))
		return null
	return Data.save["flags"][part].get(flag)

func set_flag(status:Variant, flag:String, part:int = 0)->void:
	if status == "INCREMENT": Data.save["flags"][part].set(flag, get_flag(flag, part)+1)
	elif status == "DECREMENT": Data.save["flags"][part].set(flag, get_flag(flag, part)-1)
	else: Data.save["flags"][part].set(flag, status)

func get_health()->int:
	return Data.save["health"]
func set_health(amount:int)->void:
	Data.save.set("health", amount)

func get_room()->String:
	return Data.save.get("room")
func set_room(roomName:String)->void:
	Data.save.set("room", roomName)

func get_jumps()->int:
	return Data.save.get("jumps")
func set_jumps(amount:int)->void:
	Data.save.set("jumps", amount)

func set_total_deaths(amount:int)->void:
	Data.save.set("total_deaths", amount)
func get_total_deaths()->int:
	return Data.save.get("total_deaths")
func increase_total_deaths()->void:
	set_total_deaths(Data.save.get("total_deaths")+1)

func set_death_reason(node_name:String)->void:
	Data.save.set("death_reason", node_name)
func get_death_reason()->String:
	return Data.save.get("death_reason")

func get_syn_status()->int:
	return Data.save.get("syn")
func set_syn_status(status:int)->void:
	Data.save.set("syn", status)



## SAVING AND LOADING
