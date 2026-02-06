class_name ShootingComponent
extends Marker2D

@export_file_path() var bullet_file_path:String
var bullet_scene:PackedScene
@export var sound_node:AudioStreamPlayer2D
@export var sound_type:String = "gun"

func _ready():
	if (bullet_file_path != null):
		bullet_scene = load(bullet_file_path)

func shoot()->void:
	Voice.noise(sound_node, sound_type)
	var b = bullet_scene.instantiate()
	b.global_position = global_position
	b.direction = owner.direction
	owner.owner.add_child(b)
