extends Node2D

@onready var s:Sprite2D = $Sprite

func _ready()->void:
	if Data.get_flag("amy_steak",1): s.texture = load("res://characters/amy_steak/Amy Steak.png")
	
	await get_tree().create_timer(5).timeout
	get_tree().call_deferred("quit")
