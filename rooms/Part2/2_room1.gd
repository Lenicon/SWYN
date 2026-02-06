extends RoomComponent

@export var door:Node2D

func _process(_delta):
	if Voice.before_this("intro",2) and Voice.seconds_in(21.5) and !Data.save["syn"]["active"]:
		Data.save["syn"]["active"] = true
		pig.update_syn()
	
	if Voice.before_this("intro",2) and Voice.seconds_in(62) and !Data.save["syn"]["active"]:
		Data.save["syn"]["active"] = true
		pig.update_syn()
