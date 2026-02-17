class_name GravityComponent
extends Node

@export_subgroup("Settings")
@export var gravity:float = 1000.0
@export var fall_gravity:float = 0

var is_falling:bool = false

func get_gravity(body:PhysicsBody2D) -> float:
	if body.velocity.y < 0:
		return gravity
	else:
		return fall_gravity if fall_gravity!=0 else gravity

func handle_gravity(body:PhysicsBody2D, delta:float)->void:
	if not body.is_on_floor():
		if body.velocity.y < 0:
			body.velocity.y += gravity * delta
		else:
			body.velocity.y += (fall_gravity if fall_gravity!=0 else gravity) * delta

	is_falling = body.velocity.y > 0 and not body.is_on_floor()
