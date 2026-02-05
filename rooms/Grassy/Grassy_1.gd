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

func _ready():
	Voice.done_talking.connect(_on_voice_finished)
	possible_truffle_spots.shuffle()
	truffles[0].global_position = possible_truffle_spots[0]
	truffles[1].global_position = possible_truffle_spots[1]
	truffles[2].global_position = possible_truffle_spots[2]

func _on_voice_finished(voice:String):
	if voice == "intro,1":
		await get_tree().create_timer(1).timeout
		Voice.talk("controls",1)
