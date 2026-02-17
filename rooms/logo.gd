extends CanvasLayer

func _ready():
	await get_tree().create_timer(0.5).timeout
	$AnimationPlayer.play("logo")

func main_menu()->void:
	get_tree().change_scene_to_file("res://rooms/MainMenu.tscn")
