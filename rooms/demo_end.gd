extends RoomComponent

@onready var door:Area2D = $Door
@onready var dlabel:Label = $Label2
@onready var label:Label = $Label

func _enter()->void:
	Voice.talk("demo_end")
	door.visible = false
	label.visible = false
	dlabel.visible = false
	pig.update_syn()
	

func _process(_delta)->void:
	if Voice.before_this("demo_end") and Voice.seconds_in(2.5) and !label.visible:
		label.visible = true
	
	if Voice.before_this("demo_end") and Voice.seconds_in(12) and !door.visible:
		door.visible = true
		dlabel.visible = true
