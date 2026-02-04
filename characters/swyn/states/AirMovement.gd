extends State

func enter(_previous_state_path: String, data : Dictionary = {}) -> void:
	if data.has("input"):
		if data.input == "jump":
			owner.jumps = owner.max_jumps
			if owner.jumps > 0: owner.jump()

	#owner.jump_buffer_active = false

func handle_input(event:InputEvent)->void:
	if event.is_action_pressed("jump") and owner.jumps > 0:
		owner.jump()


var in_air:bool = false
func physics_update(delta:float) -> void:
	owner.handle_variable_jump_height(Input.is_action_just_released("jump"))
	owner.handle_horizontal_movement(delta)
	
	#if owner.graphics.scale.x != owner.direction:
		#owner.graphics.scale.x = owner.direction
	
	#owner.handle_dash()
	
	if not owner.is_on_floor():
		if not in_air:
			in_air = true
		owner.play_animation("jump")
	
	else:
		in_air = false
		owner.jumps = owner.max_jumps
		#owner.reset_dash()
		finish("FloorMovement")
	
	owner.gravity_component.handle_gravity(owner, delta)
	owner.move_and_slide()


#func _on_jump_buffer_collision_body_entered(body):
	#if body is StaticBody2D:
		#owner.jump_buffer_active = true
		#owner.jumps = owner.max_jumps
		##owner.reset_dash()
		#finish("FloorMovement")

	
