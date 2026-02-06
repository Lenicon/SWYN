extends State

func enter(_previous_state_path: String, _data : Dictionary = {}) -> void:
	
	pass

func update(_delta: float) -> void:
	
	pass


func _on_detection_body_entered(body):
	if body.is_in_group("Pig"):
		owner.pig = body
