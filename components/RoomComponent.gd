class_name RoomComponent
extends Node2D

@export var room_name:String
@export var save_on_ready:bool = true
@export var pig: CharacterComponent
@export var ui:UIComponent
@export var bgm_name: String = "main"

func _ready():
	if room_name!="": Data.set_room(room_name)
	else: Data.set_room(name)
	
	if save_on_ready: Data.save_data()
	
	if (!Voice.bgm.playing):
		Voice.play_bgm(bgm_name)
	_enter()

func _enter()->void:
	pass
