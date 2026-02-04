class_name CameraComponent
extends Camera2D

@export var player: CharacterComponent = null
func _ready():
	if (player == null):
		if (owner.has_node("Swyn")):
			player = owner.get_node("Swyn")

func _physics_process(delta):
	global_position = lerp(global_position, player.global_position, 0.8)
	#global_position = player.global_position
