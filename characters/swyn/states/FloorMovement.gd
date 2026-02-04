extends State

@export var coyote_timer: Timer

func enter(_previous_state_path: String, _data : Dictionary = {}) -> void:
	owner.jumps = owner.max_jumps

#func handle_input(event:InputEvent) -> void:
	#pass

func physics_update(delta:float) -> void:
	owner.handle_horizontal_movement(delta)
	handle_coyote_time()

	#if Input.is_action_just_pressed("jump"):
		#finish("AirMovement", {"input":"jump"})
	
	
	if owner.is_on_floor():
		if abs(owner.x_input) > 0: owner.play_animation("walk")
		else: owner.play_animation("idle")

	owner.gravity_component.handle_gravity(owner, delta)
	owner.move_and_slide()

func handle_coyote_time() -> void:
	if not owner.is_on_floor() and coyote_timer.is_stopped():
		coyote_timer.start()


func _on_coyote_timer_timeout():
	if not owner.is_on_floor():
		finish("AirMovement")
