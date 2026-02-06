extends RoomComponent

func _ready()->void:
	if !Voice.before_this("move_on",1):
		Voice.talk("intro",2)
	Voice.done_talking.connect(_on_done_talking)

func _on_done_talking(voice:String, part:int)->void:
	if (voice == "move_on" or voice == "truffle_found3") and part == 1:
		Voice.talk("intro",2)

func _process(_delta):
	if Voice.before_this("intro",2) and Voice.seconds_in(15):
		get_tree().change_scene_to_file("res://rooms/Part2/2_Room1.tscn")
