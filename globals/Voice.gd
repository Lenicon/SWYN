extends AudioStreamPlayer

signal done_talking(voice:String)

func _ready():
	$BGM.play()

var current_file:String
func talk(filename:String, part:int = 0):
	current_file = filename+(","+str(part) if part!=0 else "")
	stream = load("res://assets/audio/voices"+("/part"+str(part)+"/" if part!=0 else "")+"/voice_"+("part"+str(part) if part!=0 else "")+filename+".mp3")
	if stream:
		play()



func _on_finished():
	done_talking.emit(current_file)
