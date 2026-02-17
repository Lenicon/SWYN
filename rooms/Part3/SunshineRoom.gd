class_name SunshineRoom
extends RoomComponent

@export var sunshine:CharacterBody2D
@export var doors:Array[Door]
@export var buttons:Array[TouchButton]

func _ready() -> void:
	if pig == null: pig = get_node_or_null("Swyn")
	if sunshine == null: sunshine = get_node_or_null("Sunshine")
	
	Voice.stop_bgm()
	_enter()

func _input(event:InputEvent)->void:
	if event.is_action_pressed("jump") and sunshine!=null:
		sunshine.order(pig.global_position.x)
	
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
