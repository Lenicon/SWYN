extends Area2D
class_name Door

@export var custom_appearance:Texture = null
@export var room:String
@onready var s:Sprite2D = $Door
@onready var l:Label = $Label

func _ready():
	l.visible = false
	if custom_appearance != null:
		s.texture = custom_appearance

signal enter

func _input(event:InputEvent)->void:
	if event.is_action_pressed("enter") and is_near_door:
		if room!="":
			enter.emit()
			Data.set_room(room)
			Clock.stop_time()
			if room.begins_with("0/"): get_tree().change_scene_to_file("res://rooms/"+room.replace("0/","")+".tscn")
			else: get_tree().change_scene_to_file("res://rooms/Part"+room.get_slice("_",0)+"/"+room+".tscn")

@onready var a1:AudioStreamPlayer2D = $door_open
@onready var a2:AudioStreamPlayer2D = $door_close
var is_near_door:bool = false
func _on_body_entered(body:Node2D) -> void:
	if (visible and body.is_in_group("Pig") and a1.is_inside_tree()):
		is_near_door = true
		l.visible = true
		s.frame = 1
		a1.play()


func _on_body_exited(body:Node2D) -> void:
	if (visible and body.is_in_group("Pig") and a2.is_inside_tree()):
		is_near_door = false
		l.visible = false
		s.frame = 0
		a2.play()
