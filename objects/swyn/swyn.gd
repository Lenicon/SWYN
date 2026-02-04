extends CharacterBody2D

@onready var anim :AnimationPlayer = $AnimationPlayer

func _ready():
	anim.play("walk");
