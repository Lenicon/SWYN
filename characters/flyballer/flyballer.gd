extends CharacterComponent
var pig:CharacterComponent = null
@export var sprite:Node2D
@export var speed:float = 100

var vector_direction:Vector2

func _process(_delta)->void:
	#if direction > 0: sprite.scale.x = 1
	#else: sprite.scale.x = -1
	
	if pig != null:
		if pig.global_position.x <= global_position.x and direction==1:
			sprite.scale.x = 1
			direction = 1
		else:
			sprite.scale.x = -1
			direction = -1
		sprite.look_at(pig.global_position)
