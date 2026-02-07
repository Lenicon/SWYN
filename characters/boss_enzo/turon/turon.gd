extends BulletComponent

@onready var s:Node2D = $sprite
@export var rotation_speed:float = 30

func _physics_process(delta:float) -> void:
	s.rotation +=  rotation_speed * delta
	
	if is_on_wall() or is_on_floor() or is_on_ceiling():
		die()
	
	handle_directional_movement()
	
	move_and_slide()

func die():
	queue_free()
