extends CharacterComponent

@export var s:Node2D
@export var face:Sprite2D
@export var pig:CharacterComponent = null
@export var move_timer:Timer

@export var v1:AudioStreamPlayer2D
@export var v2:AudioStreamPlayer2D
@export var v3:AudioStreamPlayer2D

@export var shooting_component:ShootingComponent

var phase:int = 1

func _ready():
	health_component.invulnerable = true
	s.scale = Vector2.ONE
	if pig == null:
		pig = owner.pig

var err:float = 1
func _process(_delta:float)->void:
	if global_position.x >= pig.global_position.x:
		s.scale.x = err
	elif global_position.x < pig.global_position.x: s.scale.x = -err

func die()->void:
	state_machine.transition_to_next_state("Dead")

func _on_health_component_health_changed(_initial:int, current:int)->void:
	if current <= float(health_component.initial_health)/4 and phase == 1:
		s.scale = Vector2(0.8,0.8)
		err = 0.8
		phase = 2
		v3.play()
		state_machine.get_node("Shoot").max_shots += 3

func phase2_shot()->void:
	if phase != 1:
		var tp:Vector2 = global_position.direction_to(pig.global_position)
		shooting_component.shoot(tp)
