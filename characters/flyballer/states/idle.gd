extends State

@export var move_time:float = 2

func enter(_previous_state_path: String, _data : Dictionary = {}) -> void:
	owner.play_animation("fly")

#var direction:int = 1
var timer:float = 0
func update(delta: float) -> void:
	if owner.pig == null:
		timer += delta
		
		if timer >= move_time:
			owner.direction *= -1
			timer = 0.0
		
		owner.velocity.x = owner.direction * owner.speed
		if owner.direction > 0: owner.sprite.scale.x = -1
		else: owner.sprite.scale.x = 1
		
		owner.move_and_slide()


func _on_detection_body_entered(body):
	if body.is_in_group("Pig") and state_machine.state.name == "Idle":
		owner.pig = body
		finish("Aggro")
