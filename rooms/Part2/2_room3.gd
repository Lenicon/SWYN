extends RoomComponent

@export var enemies:Node2D
@export var door:Area2D

func _enter():
	Voice.play_bgm("part2_rooms")
	door.visible = false
	Data.set_syn_status(Data.SYN_STATUS.CANNON)
	pig.set_health(5)
	ui.update_hp(Data.get_health())
	pig.update_syn()
	Clock.start_time()

func _process(_delta)->void:
	if enemies.get_child_count()<=0 and !Voice.before_this("stage2_clear",2):
		Voice.talk("stage2_clear",2)
	
	if Voice.before_this("stage2_clear",2) and Voice.seconds_in(8) and !door.visible:
		door.visible = true
	
	if Clock.elapsed_time >= 5 and !Data.get_flag("stage2_intro",2):
		Voice.talk("stage2_intro",2)
		Data.set_flag(true, "stage2_intro",2)
