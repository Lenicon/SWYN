extends CanvasLayer

func _ready():
	Data.load_data()
	await get_tree().create_timer(0.5).timeout
	$AnimationPlayer.play("logo")

func main_menu()->void:
	if !Data.get_flag("tampered_with_data"):
		get_tree().change_scene_to_file("res://rooms/MainMenu.tscn")
	else:
		get_tree().change_scene_to_file("res://rooms/TamperedData.tscn")
