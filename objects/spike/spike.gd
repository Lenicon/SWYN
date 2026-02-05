extends Area2D

@export var respawn_scene:String = "Part1/Grassy_1"
@onready var op:Node2D = owner
func _on_body_entered(body:Node2D)->void:
	if body.is_in_group("Pig"):
		if (Data.save["deaths"] >= 0 and Data.save["deaths"] < 6) or Data.save["deaths"] == 9:
			Data.save["deaths"] += 1
			Voice.talk("death"+str(Data.save["deaths"]),1)
			if (Voice.is_playing):
				op.pig.disable_movement()
				var b = load("res://objects/spike/Blip.tscn").instantiate()
				b.global_position = op.pig.global_position
				op.add_child(b)
				await get_tree().create_timer(1).timeout
				get_tree().call_deferred("change_scene_to_file", "res://rooms/"+respawn_scene+".tscn")
