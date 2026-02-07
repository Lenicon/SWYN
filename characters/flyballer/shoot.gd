extends State

func enter(_previous_state_path: String, _data : Dictionary = {}) -> void:
	owner.play_animation("gonna_shoot")

func update(_delta: float) -> void:
	if owner.pig != null:
		owner.vector_direction = owner.global_position.direction_to(owner.pig.global_position)

@export var shooting_component:ShootingComponent
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "gonna_shoot":
		shooting_component.shoot(owner.vector_direction)
		finish("Aggro")
		
