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
	"room_path": "", #saved as a path
	"total_deaths": 0,
	"death_reason":"",
	"syn": SYN_STATUS.NONE,
	"flags":{
		0:{
			"finished_main_menu":false,
			"tampered_with_data":false,
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
	if !save["flags"][part].has(flag): 
		printerr('"'+flag+'"' + " does not exist in part "+str(part))
		return null
	return save["flags"][part].get(flag)

func set_flag(status:Variant, flag:String, part:int = 0)->void:
	if status is String:
		if status == "INCREMENT": save["flags"][part].set(flag, get_flag(flag, part)+1)
		elif status == "DECREMENT": save["flags"][part].set(flag, get_flag(flag, part)-1)
		else: save["flags"][part].set(flag, status)
	else: save["flags"][part].set(flag, status)

func get_health()->int:
	return save["health"]
func set_health(amount:int)->void:
	save.set("health", amount)

func get_room()->String:
	return save.get("room_path")
func set_room(room:String)->void:
	if room.begins_with("res://"): save.set("room_path", room)
	else: save.set("room_path", convert_room_name_to_path(room))

func convert_room_name_to_path(room_name:String)->String:
	if room_name.begins_with("0/"):
		return "res://rooms/"+room_name.replace("0/","")+".tscn"
	return "res://rooms/Part"+room_name.get_slice("_",0)+"/"+room_name+".tscn"

func get_jumps()->int:
	return save.get("jumps")
func set_jumps(amount:int)->void:
	save.set("jumps", amount)

func set_total_deaths(amount:int)->void:
	save.set("total_deaths", amount)
func get_total_deaths()->int:
	return save.get("total_deaths")
func increase_total_deaths()->void:
	set_total_deaths(save.get("total_deaths")+1)

func set_death_reason(node_name:String)->void:
	save.set("death_reason", node_name)
func get_death_reason()->String:
	return save.get("death_reason")

func get_syn_status()->int:
	return save.get("syn")
func set_syn_status(status:int)->void:
	save.set("syn", status)



## SAVING AND LOADING
const SAVE_PATH:String = "user://this_is_your_save_file.dat"
const SECURITY_KEY:String = "H3yDumbA55_This1sTh33ncrypti0nPassw0rd_D0N'TY0uF0ck1ngUSEITB1TCH!"

func save_data()->void:
	var json_string:String = JSON.stringify(save)
	
	# for checking if save was altered
	var checksum:String = Marshalls.utf8_to_base64(json_string.sha256_text())
	
	var final_save_package = {
		"contents": json_string,
		"checksum": checksum
	}
	
	var file = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.WRITE, SECURITY_KEY)
	if file:
		file.store_string(JSON.stringify(final_save_package))
		file.close()
		print("Saved game")

func load_data()->void:
	if not FileAccess.file_exists(SAVE_PATH): return
	
	var file:FileAccess = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.READ, SECURITY_KEY)
	if file:
		var wrapper_string:String = file.get_as_text()
		file.close()
		
		var json:JSON = JSON.new()
		if json.parse(wrapper_string) == OK:
				var wrapper = json.get_data()
				
				# validation if file was altered
				var stored_checksum = wrapper.get("checksum", "")
				var actual_content = wrapper.get("contents", "")
				var current_hash:String = Marshalls.utf8_to_base64(actual_content.sha256_text())
				
				if stored_checksum == current_hash:
					# if file was not altered, load data
					var data_json = JSON.new()
					if data_json.parse(actual_content) == OK:
						update_data(save, data_json.get_data())
						print("Data loaded")
					else:
						set_flag(true, "tampered_with_data")
						save_data()

# recursive merge
func update_data(target:Dictionary, source:Dictionary):
	for key in source.keys():
		if target.has(key):
			if typeof(source[key]) == TYPE_DICTIONARY:
				update_data(target[key], source[key])
			else:
				target[key] = source[key]
