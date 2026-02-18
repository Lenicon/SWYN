extends Node2D

@onready var PLAYBUTTON:Button = $PLAYBUTTON
func _ready():
	if Data.get_flag("tampered_with_data"):
		get_tree().change_scene_to_file("res://rooms/TamperedData.tscn")
	
	if Data.get_room()!="": PLAYBUTTON.text = "Press to CONTINUE"
	else: PLAYBUTTON.text = "Press to PLAY"
	
	Voice.play_bgm("main")
	if !Data.get_flag("finished_main_menu") and !Voice.before_this("demo_end"): Voice.talk("main_menu")
	Voice.done_talking.connect(_on_done_talking)

func _on_button_pressed():
	Voice.stop()
	if Data.get_room() == "":
		get_tree().change_scene_to_file("res://rooms/Part1/1_Intro.tscn")
	else:
		get_tree().change_scene_to_file(Data.get_room())

@onready var oink:AudioStreamPlayer2D = $oink
func _on_oink_pressed():
	Voice.noise(oink, "oink")

func _on_done_talking(voice:String, _part:int)->void:
	if voice == "main_menu":
		Data.set_flag(true, "finished_main_menu")
		Data.save_data()


func _on_moo_pressed():
	Voice.noise(oink, "moo")
