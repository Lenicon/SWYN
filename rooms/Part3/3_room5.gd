extends SunshineRoom

func _enter() -> void:
	Voice.stop()
	lock.enabled = false


func _on_disabler_body_entered(body:Node2D)->void:
	if body.is_in_group("Pig"):
		pig.gravity_component.fall_gravity = 600
		body.disable_movement()


func _on_enabler_body_entered(body:Node2D)->void:
	if body.is_in_group("Pig"):
		pig.gravity_component.fall_gravity = 4000
		body.enable_movement()

@export var camera:CameraComponent
@onready var lock:TileMapLayer = $Lock
@onready var asdasd:AudioStreamPlayer2D = $asdasd
func _on_locker_body_entered(body:Node2D)->void:
	if body.is_in_group("Pig") and !lock.enabled:
		Voice.noise(asdasd,"oink")
		camera.camera_offset.y = -200
		lock.enabled = true

func _input(_event:InputEvent)->void:
	pass
