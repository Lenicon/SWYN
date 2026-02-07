extends CharacterComponent

@export var face:Sprite2D
@export var pig:CharacterComponent = null
@export var move_timer:Timer

@export var v1:AudioStreamPlayer2D
@export var v2:AudioStreamPlayer2D
@export var v3:AudioStreamPlayer2D

@export var shooting_component:ShootingComponent

var phase:int = 1

func _ready():
	if pig == null:
		pig = owner.pig



func _on_health_component_health_changed(_initial:int, current:int)->void:
	if current <= float(health_component.initial_health)/4 and phase == 1:
		phase = 2
		v3.play()
		state_machine.get_node("Shoot").max_shots += 3
