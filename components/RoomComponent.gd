class_name RoomComponent
extends Node

@export var pig: CharacterComponent
@export var ui:UIComponent
@export var bgm_name: String = "main"

func _ready():
	if (!Voice.bgm.playing):
		Voice.play_bgm(bgm_name)
	_enter()

func _enter()->void:
	pass
