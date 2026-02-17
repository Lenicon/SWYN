extends State


func enter(_previous_state_path: String, _data : Dictionary = {}) -> void:
	owner.play_animation("idle")
	owner.face.frame = 2
	#Voice.done_talking.connect(_on_dt)
	#if Voice.before_this("boss_fight", 2):
		#_speak()

var spoken:bool = false
func update(_delta: float) -> void:
	if Voice.bgm_name == "boss_enzo" and !spoken:
		spoken = true
		_speak()

#func _on_dt(voice:String, part:int)->void:
	#if voice == "boss_fight" and part == 2:
		#_speak()

func _speak()->void:
	owner.face.frame = 1
	owner.v1.play()
	await get_tree().create_timer(2).timeout
	owner.health_component.invulnerable = false
	finish("Idle")
