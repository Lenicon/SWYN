extends State

@export var shoot_state:State

func enter(_previous_state_path: String, data : Dictionary = {}) -> void:
	#owner.play_animation("jump")
	
	if data.has("input"):
		if data.input == "jump":
			owner.jumps = Data.get_jumps()
			if owner.jumps > 0: owner.jump()

	#owner.jump_buffer_active = false

func handle_input(event:InputEvent)->void:
	if event.is_action_pressed("jump") and owner.jumps > 0:
		owner.jump()
	
	if event.is_action("shoot") and shoot_state.ammo>0 and owner.syn.visible:
		owner.play_animation("idle")
		finish("Shoot")


#var in_air:bool = false
func physics_update(delta:float) -> void:
	owner.handle_variable_jump_height(Input.is_action_just_released("jump"))
	owner.handle_horizontal_movement(delta)
	
	#if owner.graphics.scale.x != owner.direction:
		#owner.graphics.scale.x = owner.direction
	
	#owner.handle_dash()
	
	if not owner.is_on_floor():
		#finish("AirMovement")
		owner.rotate_core(delta)
		#if not in_air:
			#in_air = true
		#owner.play_animation("jump")
	
	else:
		#in_air = false
		owner.jumps = Data.get_jumps()
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

	
