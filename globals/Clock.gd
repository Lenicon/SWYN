extends Node

var elapsed_time:float = 0
var is_playing:bool = false

func start_time()->void:
	reset_time()
	play_time()

func reset_time()->void:
	elapsed_time = 0

func stop_time()->void:
	pause_time()
	reset_time()
	
func pause_time()->void:
	is_playing = false

func play_time()->void:
	is_playing = true

func _process(delta:float)->void:
	if is_playing:
		elapsed_time += delta
