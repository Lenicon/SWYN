extends State

@export var max_shots:int = 3
var shots:int = 5

func _ready():
	shots = max_shots

func enter(previous_state_path: String, _data : Dictionary = {}) -> void:
	if previous_state_path == "Idle":
		shots = max_shots
	
	if shots > 0:
		var target_position:Vector2 = owner.global_position.direction_to(owner.pig.global_position)
		owner.shooting_component.shoot(target_position)
		shots -= 1
		await get_tree().create_timer(1).timeout
		finish("Shoot")
	else:
		finish("Idle")
