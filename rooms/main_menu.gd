extends Node2D

func _ready():
	if !Data.check_flag("finished_main_menu"): Voice.talk("main_menu")
	Voice.done_talking.connect(_on_done_talking)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://rooms/Part1/1_Intro.tscn")

@onready var oink:AudioStreamPlayer2D = $oink
func _on_oink_pressed():
	Voice.noise(oink, "oink")

func _on_done_talking(voice:String, _part:int)->void:
	if voice == "main_menu":
		Data.set_flag("finished_main_menu")
