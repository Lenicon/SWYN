extends Area2D
@export var id:int
@export var stage:RoomComponent
@export var sprite:Sprite2D
@export var appearance:Texture

func _ready():
	sprite.texture = appearance

func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("Pig"):
		stage.truffles[id] = null
		stage.increase_truffle()
		await get_tree().create_timer(1).timeout
		stage.pig.enable_movement()
		queue_free()
