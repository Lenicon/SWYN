extends RoomComponent

@export var door:Node2D

func _process(_delta):
	if Voice.before_this("intro",2) and Voice.seconds_in(21.5) and !Data.save["syn"]["active"]:
		Data.save["syn"]["active"] = true
		pig.update_syn()
	
	if Voice.before_this("intro",2) and Voice.seconds_in(65) and !ui.visible:
		pig.set_health(3)
		ui.update_hp(3)
		ui.visible = true
	
	if Voice.before_this("intro",2) and Voice.seconds_in(72) and Data.save["health"] == 3:
		pig.set_health(5)
		ui.update_hp(5)
	
	if Voice.before_this("intro",2) and Voice.seconds_in(82) and !door.visible:
		door.visible = true
