class_name BulletComponent
extends CharacterBody2D

@export var hitbox_component: HitBoxComponent
@export var direction:int = 1
@export var vector_direction = Vector2.RIGHT
@export var acceleration:float = 5.0
@export var speed:float = 160

func _ready():
	if hitbox_component == null: hitbox_component = get_node("HitBoxComponent")

func handle_horizontal_movement(delta:float) -> void:
	velocity.x = lerp(velocity.x, direction * speed, delta * acceleration)

func handle_directional_movement()->void:
	velocity = vector_direction * speed * acceleration
