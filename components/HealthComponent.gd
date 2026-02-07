class_name HealthComponent
extends Node

@export var initial_health: int
@export var current_health: int
@export var character: Node2D

signal health_changed(initial:int, current:int)
signal health_decreased(amount:int)
signal health_increased(amount:int)

var invulnerable:bool = false
var invul_timer:Timer
@export var invul_time:float = 0.5


func _ready()->void:
	current_health = initial_health
	invul_timer = Timer.new()
	invul_timer.wait_time = invul_time
	invul_timer.one_shot = true
	owner.call_deferred("add_child", invul_timer)
	invul_timer.timeout.connect(_on_invul_timeout)

func decrease(amount:int)->void:
	#print(character, current_health, amount)
	
	if !invulnerable:
		var cr: int = current_health
		current_health -= amount
		health_changed.emit(cr, current_health)
		health_decreased.emit(amount)
		
		if (current_health <= 0):
			if (character.has_method("die")):
				character.die()
			else:
				character.queue_free()
		
		invulnerable = true
		invul_timer.start()

func increase(amount:int)->void:
	var cr: int = current_health
	current_health += amount
	health_changed.emit(cr, current_health)
	health_increased.emit(amount)

func set_health(amount:int)->void:
	health_changed.emit(current_health, amount)
	current_health = amount;
	
func _on_invul_timeout()->void:
	invulnerable = false
