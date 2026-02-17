extends RoomComponent

@export var enemies:Node2D
@export var door:Area2D

func _enter():
	Voice.play_bgm("part2_rooms")
	door.visible = false
	Data.set_syn_status(Data.SYN_STATUS.CANNON)
	pig.set_health(5)
	ui.update_hp(Data.get_health())
	pig.update_syn()

func _process(_delta)->void:
	if enemies.get_child_count()<=0 and !door.visible:
		Voice.talk("stage1_clear",2)
		door.visible = true
