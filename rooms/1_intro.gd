extends RoomComponent

func _ready() ->void:
	pig.can_move = false
	pig.visible = false
	Voice.talk("intro",1)

func _process(_delta)->void:
	if (Voice.is_playing and Voice.get_playback_position() >= 11 and !pig.visible):
		pig.visible = true
		pig.can_move = true
	
	if (Voice.is_playing and Voice.get_playback_position() >= 16 and pig.visible):
		get_tree().change_scene_to_file("res://rooms/Grassy/Grassy_1.tscn")
