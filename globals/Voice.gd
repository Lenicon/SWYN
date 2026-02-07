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

var bgm_name:String
func play_bgm(filename:String):
	bgm_name = filename
	bgm.stream = load("res://assets/audio/bgms/bgm_"+filename+".mp3")
	bgm.play()

func seconds_in(seconds:float)->bool:
	return (playing and get_playback_position() >= seconds)

func before_this(voice:String,part:int=0)->bool:
	return !current_file.is_empty() and current_file[0] == voice and current_file[1] == part

func _on_finished():
	done_talking.emit(current_file[0],current_file[1])


@onready var oink_files:Array = [
	preload("res://assets/audio/sfx/pig/oink1.mp3"),
	preload("res://assets/audio/sfx/pig/oink2.mp3"),
	preload("res://assets/audio/sfx/pig/oink3.mp3"),
	preload("res://assets/audio/sfx/pig/oink4.mp3"),
	preload("res://assets/audio/sfx/pig/oink5.mp3"),
]
@onready var moo_files:Array = [
	preload("res://assets/audio/sfx/cow/moo1.mp3"),
	preload("res://assets/audio/sfx/cow/moo2.mp3"),
	preload("res://assets/audio/sfx/cow/moo3.mp3"),
	preload("res://assets/audio/sfx/cow/moo4.mp3"),
	preload("res://assets/audio/sfx/cow/moo5.mp3"),
]
@onready var gun_files:Array = [
	preload("res://assets/audio/sfx/gun/poog1.mp3"),
	preload("res://assets/audio/sfx/gun/poog2.mp3"),
	preload("res://assets/audio/sfx/gun/poog3.mp3"),
	preload("res://assets/audio/sfx/gun/poog4.mp3"),
	preload("res://assets/audio/sfx/gun/poog5.mp3"),
]

func noise(audio_node:AudioStreamPlayer2D, type:String)->void:
	match type:
		"oink": audio_node.stream = oink_files[randi_range(0, oink_files.size()-1)]
		"moo": audio_node.stream = moo_files[randi_range(0, moo_files.size()-1)]
		"gun": audio_node.stream = gun_files[randi_range(0, gun_files.size()-1)]
		_:pass
	
	if audio_node.stream: audio_node.play()
