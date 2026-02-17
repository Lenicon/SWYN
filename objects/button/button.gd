extends Area2D
class_name TouchButton

@onready var s:Sprite2D = $sprite
@onready var a:AudioStreamPlayer = $audio
var standing_on:int = 0

func is_pressed()->bool:
	return standing_on > 0

#signal pressed
#signal unpressed
signal changed(pressed:bool)

func _on_body_entered(body:Node2D)->void:
	if body.is_in_group("Pig") or body.is_in_group("Sunshine"):
		standing_on += 1
		behavior()
		

func _on_body_exited(body:Node2D)->void:
	if body.is_in_group("Pig") or body.is_in_group("Sunshine"):
		standing_on -= 1
		behavior()
		
func behavior()->void:
	if is_pressed():
		s.frame = 1
		a.pitch_scale = 1
		a.play()
	else:
		a.pitch_scale = 1.5
		a.play()
		s.frame = 0

	changed.emit(is_pressed())
