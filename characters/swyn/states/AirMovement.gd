extends State


# Sprite for jumping on air
@onready var jump_on_air_sprite:AnimatedSprite2D = $"../../Graphics/JumpOnAir"

func enter(_previous_state_path: String, data : Dictionary = {}) -> void:
	if data.has("input"):
		if data.input == "jump":
			owner.jumps = owner.max_jumps
			show_jump_on_air_sprite()
			if owner.jumps > 0: owner.jump()

	owner.jump_buffer_active = false

func handle_input(event:InputEvent)->void:
	if event.is_action_pressed("jump") and owner.jumps > 0:
		show_jump_on_air_sprite()
		owner.jump()


func show_jump_on_air_sprite():
	if not owner.is_on_floor() and not owner.jump_buffer_active and not owner.get_traveled_animation() == "Run":
		if owner.jumps == owner.max_jumps: jump_on_air_sprite.modulate = Color("ffffffee")
		elif owner.jumps == owner.min_jumps: jump_on_air_sprite.modulate = Color("ffffff80")
		jump_on_air_sprite.global_position = owner.global_position
		jump_on_air_sprite.stop()
		jump_on_air_sprite.play("default")


var in_air:bool = false
func physics_update(delta:float) -> void:
	owner.handle_variable_jump_height(Input.is_action_just_released("jump"))
	owner.handle_spoon_attack()
	owner.handle_horizontal_movement(delta)
	
	if owner.graphics.scale.x != owner.direction and not owner.spoon_player.is_playing():
		owner.graphics.scale.x = owner.direction
	
	owner.handle_dash()
	
	
	if not owner.is_on_floor():
		if not in_air:
			in_air = true
		if owner.gravity_component.is_falling:
			owner.travel_animation("Fall")
		else:
			owner.travel_animation("Jump")
	else:
		in_air = false
		owner.jumps = owner.max_jumps
		owner.reset_dash()
		finish("FloorMovement")
	
	owner.gravity_component.handle_gravity(owner, delta)
	owner.move_and_slide()


func _on_jump_buffer_collision_body_entered(body):
	if body is StaticBody2D:
		owner.jump_buffer_active = true
		owner.jumps = owner.max_jumps
		owner.reset_dash()
		finish("FloorMovement")
