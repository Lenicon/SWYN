extends RoomComponent

@export var door:Area2D

func _enter()->void:
	door.visible = false
	Data.save["syn"]["active"] = true
	Data.save["health"] = 5
	pig.health_component.set_health(Data.save["health"])
	ui.update_hp(Data.save["health"])
	pig.update_syn()

	Voice.done_talking.connect(_on_done_talking)

	if Voice.before_this("boss_fight",2):
		if Voice.bgm_name != "boss_enzo": Voice.play_bgm("boss_enzo")
	else:
		Voice.talk("boss_fight",2)

func _process(_delta)->void:
	if Voice.before_this("beat_enzo",2) and Voice.seconds_in(10) and !door.visible:
		door.visible = true

func _on_done_talking(voice:String, part:int)->void:
	if voice == "boss_fight" and part == 2:
		Voice.play_bgm("boss_enzo")
	
