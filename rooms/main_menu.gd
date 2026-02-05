extends Node2D

func _ready():
	Voice.talk("main_menu")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://rooms/Part1/1_Intro.tscn")

@onready var oink:AudioStreamPlayer2D = $oink
func _on_oink_pressed():
	Data.oink(oink)
