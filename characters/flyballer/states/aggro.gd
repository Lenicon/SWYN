extends State

@export var min_distance:float = 100
@export var shoot_cooldown:Timer

func enter(_previous_state_path: String, _data : Dictionary = {}) -> void:
	shoot_cooldown.start()
	owner.play_animation("fly")

#var direction:Vector2
var timer:float = 0
var can_shoot:bool = true
func update(_delta: float) -> void:
	if owner.pig != null:
		owner.sprite.look_at(owner.pig.global_position)
		var distance = owner.global_position.distance_to(owner.pig.global_position)
		if distance > min_distance:
			owner.vector_direction = owner.global_position.direction_to(owner.pig.global_position)
			owner.velocity = owner.vector_direction * owner.speed
			
			owner.move_and_slide()
			
		else:
			owner.velocity = Vector2.ZERO
		
		if can_shoot:
			#print(can_shoot)
			can_shoot = false
			finish("Shoot")
		
		#print(distance)


func _on_shoot_cooldown_timeout():
	can_shoot = true
