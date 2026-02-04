class_name HealthComponent
extends Node

@export var initial_health: int
@export var current_health: int
@export var character: Node2D

signal health_changed(initial:int, current:int)
signal health_decreased(amount:int)
signal health_increased(amount:int)

func _ready():
	initial_health = current_health

func decrease(amount:int):
	var cr: int = current_health
	current_health -= amount
	health_changed.emit(cr, current_health)
	health_decreased.emit(amount)
	
	if (current_health <= 0):
		if (character.has_method("die")):
			character.die()
		else:
			character.queue_free()

func increase(amount:int):
	var cr: int = current_health
	current_health += amount
	health_changed.emit(cr, current_health)
	health_increased.emit(amount)
