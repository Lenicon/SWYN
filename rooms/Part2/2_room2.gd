extends RoomComponent

@export var enemies:Node2D
@export var door:Area2D

func _enter():
	door.visible = false
	Data.save["syn"]["active"] = true
	Data.save["health"] = 5
	pig.health_component.set_health(Data.save["health"])
	ui.update_hp(Data.save["health"])
	pig.update_syn()

func _process(_delta)->void:
	if enemies.get_child_count()<=0 and !door.visible:
		Voice.talk("stage1_clear",2)
		door.visible = true
