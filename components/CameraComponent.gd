class_name CameraComponent
extends Camera2D

@export var player: CharacterComponent = null
@export var camera_offset: Vector2

func _ready():
	if (player == null):
		if (owner.has_node("Swyn")):
			player = owner.get_node("Swyn")
	
	if (player != null):
		global_position = player.global_position


var prev
func _physics_process(_delta):
	global_position = player.global_position+camera_offset
