extends BulletComponent

@onready var s:Sprite2D = $Sprite
@export var rotation_speed:float = 30

func _physics_process(delta:float) -> void:
	s.rotation +=  direction*rotation_speed * delta
	
	if is_on_wall() or is_on_floor() or is_on_ceiling():
		die()
	
	handle_horizontal_movement(delta)
	
	move_and_slide()

func die():
	queue_free()
