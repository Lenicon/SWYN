extends Node

enum MAP {
	GRASSY,
	CAVE,
	MOON,
	HELL,
	HEAVEN
}

enum WEAPON {
	NONE,
	CANNON,
	BOMB,
	FIRE
}

var save:Dictionary = {
	"health":100,
	"jumps":2,
	"truffles":0,
	"deaths":0,
	"map":MAP.GRASSY,
	"syn":{
		"active":false,
		"weapon":WEAPON.CANNON
	}
}

@onready var oink_files = [
	preload("res://assets/audio/pig/oink1.mp3"),
	preload("res://assets/audio/pig/oink2.mp3"),
	preload("res://assets/audio/pig/oink3.mp3"),
	preload("res://assets/audio/pig/oink4.mp3"),
	preload("res://assets/audio/pig/oink5.mp3"),
]
func oink(oink_node:AudioStreamPlayer2D)->void:
	var r = randi_range(0, 4)
	oink_node.stream = oink_files[r]
	if oink_node.stream: oink_node.play()
