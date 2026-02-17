extends State

@export var coyote_timer: Timer
@export var shoot_state:State

func enter(_previous_state_path: String, _data : Dictionary = {}) -> void:
	owner.play_animation("idle")
	owner.jumps = Data.get_jumps()

#func handle_input(event:InputEvent) -> void:
	#pass

func handle_input(event: InputEvent) -> void:
	
	if event.is_action("shoot") and shoot_state.ammo>0 and owner.syn.visible:
		owner.play_animation("idle")
		finish("Shoot")

func physics_update(delta:float) -> void:
	owner.handle_horizontal_movement(delta)
	handle_coyote_time()
	
	if Input.is_action_just_pressed("jump") and owner.jumps > 0:
		#owner.play_animation("jump")
		finish("AirMovement", {"input":"jump"})
		
	if owner.is_on_floor():
		owner.body_shape.rotation = 0
		if abs(owner.x_input) > 0: owner.play_animation("walk")
		else: owner.play_animation("idle")
	else:
		owner.rotate_core(delta)

	owner.gravity_component.handle_gravity(owner, delta)
	owner.move_and_slide()

func handle_coyote_time() -> void:
	if not owner.is_on_floor() and coyote_timer.is_stopped():
		coyote_timer.start()


func _on_coyote_timer_timeout():
	if not owner.is_on_floor():
		finish("AirMovement")
