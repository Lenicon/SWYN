extends Node2D

func _ready()->void:
	Voice.stop()
	Voice.stop_bgm()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "play":
		Data.set_flag(false, "tampered_with_data")
		Data.save_data()
		get_tree().change_scene_to_file("res://rooms/MainMenu.tscn")
