extends State

@export var speed:float = 1000
var target:Vector2
func _ready():
	lunges = max_lunges

func enter(previous_state_path: String, _data : Dictionary = {}) -> void:
	if previous_state_path == "Idle":
		lunges = max_lunges
		owner.play_animation("prep_attack_2")
	else:
		await get_tree().create_timer(0.5).timeout
		is_lunging = true
		owner.v2.play()
	
	if owner.pig:
		lunges -= 1
		target = owner.pig.global_position
		

var is_lunging:bool = false
@export var max_lunges:int = 5
var lunges:int = 5
func physics_update(_delta: float) -> void:
	if owner.pig and is_lunging:
		var dir:Vector2 = (target - owner.global_position).normalized()
		if owner.global_position.distance_to(target) > 30:
			owner.velocity = dir * speed
		else:
			_refresh()
		
		if owner.is_on_wall() or owner.is_on_floor() or owner.is_on_ceiling():
			_refresh()
		
		owner.move_and_slide()
		


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "prep_attack_2":
		is_lunging = true

func _refresh()->void:
	is_lunging = false
	if lunges > 0: finish("Lunge")
	else:
		finish("Idle")

#func exit() -> void:
	#owner.velocity = Vector2.ZERO
