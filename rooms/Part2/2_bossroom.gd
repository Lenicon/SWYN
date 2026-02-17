extends RoomComponent

@export var door:Area2D
@export var boss_enzo:CharacterComponent

var enzo_easier:int = 6
var enzo_unbeaten:int = 10

func _enter()->void:
	door.visible = false
	Data.set_syn_status(Data.SYN_STATUS.CANNON)
	pig.set_health(5)
	#pig.health_component.set_health(Data)
	ui.update_hp(Data.get_health())
	pig.update_syn()

	if Data.get_flag("boss_enzo_deaths",2) >= enzo_easier and !Voice.before_this("enzo_easier",2) and !Voice.before_this("enzo_unbeaten",2):
		Voice.talk("enzo_easier",2)
	
	if Data.get_flag("boss_enzo_deaths",2) >= enzo_unbeaten and Voice.before_this("enzo_easier",2) and !Voice.before_this("enzo_unbeaten",2):
		Voice.talk("enzo_unbeaten",2)

	Voice.done_talking.connect(_on_done_talking)

	if Data.get_flag("boss_enzo_deaths",2) > 0:
		#print("why not playing")
		Voice.play_bgm("boss_enzo")
	
	if Voice.bgm_name != "boss_enzo" and Data.get_flag("boss_enzo_deaths",2) < 1:
		Voice.talk("boss_fight",2)


var changed_health:bool = false
func _process(_delta)->void:
	if Voice.before_this("beat_enzo",2) and Voice.seconds_in(10) and !door.visible:
		door.visible = true
	
	if Data.get_flag("boss_enzo_deaths",2) >= enzo_easier and !changed_health:
		boss_enzo.health_component.current_health = 30
		changed_health = true
	
	if Data.get_flag("boss_enzo_deaths",2) >= enzo_unbeaten and !door.visible:
		#Voice.stop_bgm()
		door.visible = true

func _on_done_talking(voice:String, part:int)->void:
	if (voice == "boss_fight" or voice == "enzo_easier" or voice == "enzo_unbeaten") and part == 2:
		Voice.play_bgm("boss_enzo")
	
