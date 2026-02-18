extends RoomComponent

var truffle_count:int = 0
@export var truffles:Array[Area2D]

var possible_truffle_spots:Array[Vector2] = [
	Vector2(747, 4530),
	Vector2(11919, 4528),
	Vector2(6645, 4020),
	Vector2(14998, 1703),
	Vector2(3753, -1476),
	Vector2(-201, 2616),
	Vector2(11841, 1313),
	Vector2(10733, -1284),
]

func _enter()->void:
	if !Voice.before_this("intro",1):
		Voice.talk("intro",1,13.5)
	
	Data.set_flag("INCREMENT", "deaths", 1)
	
	if (Data.get_flag("deaths",1) >= 1 and Data.get_flag("deaths",1) <= 6) or (Data.get_flag("deaths",1) == 10):
		Voice.talk("death"+str(Data.get_flag("deaths",1)),1)
	
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
	if truffle_count > Data.get_flag("truffles",1) and truffle_count <= 3:
		Voice.talk("truffle_found"+str(truffle_count), 1)
		Data.set_flag("INCREMENT", "truffles", 1)
	pig.speed += 100
	pig.jump_height += 50
	Clock.reset_time()

var spawned_truffles_state:int = 0
@export var more_truffles_after_seconds:float = 100
func _process(_delta):
	if Clock.elapsed_time >= more_truffles_after_seconds and spawned_truffles_state == 0:
		Voice.talk("more_truffles", 1)
		spawned_truffles_state = 1
	
	if Voice.seconds_in(15) and spawned_truffles_state == 1:
		pig.disable_movement()
		await get_tree().create_timer(0.01).timeout
		if truffles[4] != null:
			truffles[4].global_position = Vector2(pig.global_position.x - pig.direction*400, pig.global_position.y+15)
		if truffles[5] != null:
			truffles[5].global_position = Vector2(pig.global_position.x + pig.direction*400, pig.global_position.y+15)
		if truffles[6] != null:
			truffles[6].global_position = Vector2(pig.global_position.x + pig.direction*800, pig.global_position.y+15)
		if truffles[7] != null:
			truffles[7].global_position = Vector2(pig.global_position.x - pig.direction*800, pig.global_position.y+15)
		await get_tree().create_timer(0.1).timeout
		pig.enable_movement()
		Clock.reset_time()
		spawned_truffles_state = 2
	
	if Clock.elapsed_time >= 120 and spawned_truffles_state == 2:
		spawned_truffles_state = 3
		Voice.talk("move_on",1)
	
	if Clock.elapsed_time >= 10 and Data.get_flag("truffles", 1) >= 3 and !Voice.before_this("truffle_found3"):
		get_tree().change_scene_to_file("res://rooms/Part2/2_Intro.tscn")
		
	if Voice.before_this("move_on",1) and Voice.seconds_in(23) and spawned_truffles_state == 3:
		get_tree().change_scene_to_file("res://rooms/Part2/2_Intro.tscn")
	
	if Voice.before_this("death10",1) and Voice.seconds_in(92) and Data.get_jumps() == 2:
		Data.set_jumps(3)

func _on_amy_steak_2_body_entered(body):
	if body.is_in_group("Pig") and !Data.get_flag("amy_steak", 1):
		Voice.talk("amy_steak",1)
		Data.set_flag(true, "amy_steak", 1)
