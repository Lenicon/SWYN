extends SunshineRoom

func _enter()->void:
	Data.set_health(1)
	Data.set_syn_status(Data.SYN_STATUS.NONE)
	pig.update_syn()
	
	if Voice.before_this("demo_end"): Voice.stop()
	Clock.start_time()
	doors[0].visible = false

func _process(_delta):
	if Clock.elapsed_time >= 5 and !Voice.before_this("im_sunshine",3) and get_tree().current_scene.name == "3Room1":
		Voice.talk("im_sunshine",3)
		

func _on_button_changed(pressed:bool)->void:
	doors[0].visible = pressed
