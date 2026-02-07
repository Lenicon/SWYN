extends State

var can_attack:bool = true
func enter(_previous_state_path: String, _data : Dictionary = {}) -> void:
	owner.phase2_shot()
	
	if !can_attack: owner.move_timer.start()
	owner.play_animation("idle")
	owner.face.frame = 2


func physics_update(_delta: float) -> void:
	if can_attack:
		choose_attack()

func choose_attack()->void:
	can_attack = false
	var r:int = randi_range(0,1 if owner.phase == 1 else 3)
	match r:
		0:
			owner.phase2_shot()
			finish("Lunge")
		_: owner.play_animation("prep_attack_1")

func _on_move_timer_timeout()->void:
	can_attack = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "prep_attack_1":
		finish("Shoot")
