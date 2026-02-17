extends State

func enter(_previous_state_path: String, _data : Dictionary = {}) -> void:
	owner.play_animation("die")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "die":
		Data.set_flag(true, "boss_enzo_beaten", 2)
		Voice.talk("beat_enzo",2)
		Voice.play_bgm("main")
		
		owner.call_deferred("queue_free")
