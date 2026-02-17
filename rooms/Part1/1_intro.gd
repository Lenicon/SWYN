extends RoomComponent

func _enter() ->void:
	pig.disable_movement()
	pig.visible = false
	Voice.talk("intro",1)

func _process(_delta)->void:
	if Voice.seconds_in(11) and !pig.visible:
		pig.visible = true
		Voice.noise(pig.oink, "oink")
		pig.enable_movement()
	
	if Voice.seconds_in(16) and pig.visible:
		get_tree().change_scene_to_file("res://rooms/Part1/1_Room1.tscn")
