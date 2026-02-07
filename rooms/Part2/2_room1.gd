extends RoomComponent

@export var door:Area2D
@onready var doorsign:Label = $doorsign

func _enter()->void:
	ui.visible = false
	door.visible = false
	doorsign.visible = false

func _process(_delta):
	if Voice.before_this("intro",2) and Voice.seconds_in(21.5) and !Data.save["syn"]["active"]:
		Data.save["syn"]["active"] = true
		pig.update_syn()
	
	if Voice.before_this("intro",2) and Voice.seconds_in(30) and !door.visible:
		doorsign.visible = true
		door.visible = true
	
	if Voice.before_this("intro",2) and Voice.seconds_in(65) and !ui.visible:
		pig.set_health(3)
		ui.update_hp(3)
		ui.visible = true
	
	if Voice.before_this("intro",2) and Voice.seconds_in(72) and Data.save["health"] == 3:
		pig.set_health(5)
		ui.update_hp(5)
	
