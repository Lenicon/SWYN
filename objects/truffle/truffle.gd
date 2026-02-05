extends Area2D

@export var stage:RoomComponent
@export var sprite:Sprite2D
@export var appearance:Texture

func _ready():
	sprite.texture = appearance

func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("Pig"):
		stage.truffle_count += 1
		stage.pig.can_move = false
		stage.pig.truffle_noise.play()
		if (stage.truffle_count > Data.save["truffles"]):
			Voice.talk("truffle_found"+stage.truffle_count, 1)
			Data.save["truffles"] += 1
		await get_tree().create_timer(1).timeout
