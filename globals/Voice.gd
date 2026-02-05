extends AudioStreamPlayer

signal done_talking(voice:String,part:int)
@onready var bgm:AudioStreamPlayer = $BGM

func _ready():
	play()

var current_file:Array = []
func talk(filename:String, part:int = 0):
	current_file = [filename,part]
	stream = load("res://assets/audio/voices"+("/part"+str(part)+"/" if part!=0 else "")+"/voice_"+("part"+str(part)+"_" if part!=0 else "")+filename+".mp3")
	if stream:
		play()

func play_bgm(filename:String):
	bgm.stream = load("res://assets/audio/bgms/bgm_"+filename+".mp3")
	bgm.play()

func seconds_in(seconds:float)->bool:
	return (is_playing and get_playback_position() >= seconds)

func before_this(voice:String,part:int)->bool:
	return current_file[0] == voice and current_file[1] == part

func _on_finished():
	done_talking.emit(current_file[0],current_file[1])
