extends RoomComponent

var truffle_count:int = 0
@export var truffles:Array[Area2D]

var possible_truffle_spots:Array[Vector2] = [
	Vector2(64,2606),
	Vector2(560, 4509),
	Vector2(6393, 4008),
	Vector2(15072, 1703),
	Vector2(10831, -1288),
	Vector2(1474, -2984),
	Vector2(14177, -4986)
]

func _enter()->void:
	if (Data.save["deaths"] >= 1 and Data.save["deaths"] <= 6 and Data.save["part"]==1) or (Data.save["deaths"] == 10):
		Voice.talk("death"+str(Data.save["deaths"]),1)
	
	Clock.start_time()
	Voice.done_talking.connect(_on_voice_finished)
	possible_truffle_spots.shuffle()
	truffles[0].global_position = possible_truffle_spots[0]
	truffles[1].global_position = possible_truffle_spots[1]
	truffles[2].global_position = possible_truffle_spots[2]
	truffles[3].global_position = possible_truffle_spots[3]

func _on_voice_finished(voice:String, part:int)->void:
	if voice == "intro" and part == 1:
		await get_tree().create_timer(1).timeout
		Voice.talk("controls",1)
		
	if voice == "truffle_found3" and part == 1:
		get_tree().change_scene_to_file("res://rooms/Part2/2_Intro.tscn")

func increase_truffle()->void:
	truffle_count += 1
	pig.disable_movement()
	pig.velocity.x = 0
	pig.truffle_noise.play()
	if (truffle_count > Data.save["truffles"]):
		Voice.talk("truffle_found"+str(truffle_count), 1)
		Data.save["truffles"] += 1
	pig.speed += 100
	pig.jump_height += 50
	Clock.reset_time()

var spawned_truffles_state:int = 0
func _process(_delta):
	if Clock.elapsed_time >= 200 and spawned_truffles_state == 0:
		Voice.talk("more_truffles", 1)
		spawned_truffles_state = 1
	
	if Voice.seconds_in(13) and spawned_truffles_state == 1:
		pig.disable_movement()
		await get_tree().create_timer(0.01).timeout
		if truffles[0] != null:
			truffles[0].global_position = Vector2(pig.global_position.x - pig.direction*400, pig.global_position.y+10)
		if truffles[1] != null:
			truffles[1].global_position = Vector2(pig.global_position.x + pig.direction*400, pig.global_position.y+10)
		if truffles[2] != null:
			truffles[2].global_position = Vector2(pig.global_position.x + pig.direction*800, pig.global_position.y+10)
		if truffles[3] != null:
			truffles[3].global_position = Vector2(pig.global_position.x - pig.direction*800, pig.global_position.y+10)
		await get_tree().create_timer(0.1).timeout
		pig.enable_movement()
		Clock.reset_time()
		spawned_truffles_state = 2
	
	if Clock.elapsed_time >= 60 and spawned_truffles_state == 2:
		spawned_truffles_state = 3
		Voice.talk("move_on",1)
		
	if Voice.before_this("move_on",1) and Voice.seconds_in(23) and spawned_truffles_state == 3:
		get_tree().change_scene_to_file("res://rooms/Part2/2_Intro.tscn")
	
	if Voice.before_this("death10",1) and Voice.seconds_in(92) and Data.save["jumps"] == 2:
		Data.save["jumps"] = 3

func _on_amy_steak_2_body_entered(body):
	if body.is_in_group("Pig") and !Data.check_flag("amy_steak",1):
		Voice.talk("amy_steak",1)
		Data.set_flag("amy_steak",1)
