extends Node2D
@onready var sprite:Sprite2D = $Sprite2D
@onready var moo:AudioStreamPlayer2D = $Moo


func _on_body_entered(body):
	if body.is_in_group("Pig"):
		if body.global_position.x < global_position.x:
			sprite.flip_h = true
		else: sprite.flip_h = false
		Voice.noise(moo, "moo")
