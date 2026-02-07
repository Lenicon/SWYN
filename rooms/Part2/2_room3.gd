extends RoomComponent

@export var enemies:Node2D
@export var door:Area2D

func _enter():
	door.visible = false
	Data.save["syn"]["active"] = true
	Data.save["health"] = 5
	pig.health_component.set_health(Data.save["health"])
	ui.update_hp(Data.save["health"])
	pig.update_syn()
	Clock.start_time()

func _process(_delta)->void:
	if enemies.get_child_count()<=0 and !Voice.before_this("stage2_clear",2):
		Voice.talk("stage2_clear",2)
	
	if Voice.before_this("stage2_clear",2) and Voice.seconds_in(8) and !door.visible:
		door.visible = true
	
	if Clock.elapsed_time >= 5 and !Data.check_flag("stage2_intro",2):
		Voice.talk("stage2_intro",2)
		Data.set_flag("stage2_intro",2)
