extends RoomComponent

@export var door:Area2D
@onready var doorsign:Label = $doorsign

func _enter()->void:
	ui.visible = false
	door.visible = false
	doorsign.visible = false
	Voice.done_talking.connect(done_talking)

func _process(_delta):
	if Voice.before_this("intro",2) and Voice.seconds_in(21.5) and Data.get_syn_status() < Data.SYN_STATUS.CANNON:
		Data.set_syn_status(Data.SYN_STATUS.CANNON)
		pig.update_syn()
	
	if Voice.before_this("intro",2) and Voice.seconds_in(30) and !door.visible:
		doorsign.visible = true
		door.visible = true
	
	if Voice.before_this("intro",2) and Voice.seconds_in(65) and !ui.visible:
		pig.set_health(3)
		ui.update_hp(3)
		ui.visible = true
	
	if Voice.before_this("intro",2) and Voice.seconds_in(72) and Data.get_health() == 3:
		pig.set_health(5)
		ui.update_hp(5)
	

var d:bool = false
func _on_door_enter()->void:
	if Voice.before_this("intro",2) and (!Voice.seconds_in(72) or d):
		Voice.talk("shut_up",2)

func done_talking(voice:String, part:int)->void:
	if voice == "intro" and part == 2:
		d = true
