##################
## DO NOT MODIFY #
##################

################### DOCUMENTATION ########################
## ADD A CollisionShape2D UNDER THIS COMPONENT TO USE THIS.
## MULTIPLE CollisionShape2D CAN BE ADDED UNDER THIS COMPONENT.
## 
## FOR ATTACKS, HITBOX CollisionShape2D MUST BE MANUALLY ANIMATED IN AnimationPlayer2D
##
## This is responsible for dealing damage to Objects with HurtBoxComponent and HealthComponent
##
## set_damage                    Set Damage this Hitbox causes
## get_damage                  Get Damge this Hitbox casuses
##

class_name HitBoxComponent
extends Area2D

@export var initial_damage:int
@export var current_damage:int : set = set_current_damage

func _ready() -> void:
	current_damage = initial_damage
	set_monitoring(false)
	set_collision_mask_value(1, false)

func enable() -> void:
	for child in get_children():
		if is_instance_of(child, CollisionShape2D):
			child.disabled = false

func disable() -> void:
	for child in get_children():
		if is_instance_of(child, CollisionShape2D):
			child.disabled = true
		
func set_current_damage(value:int) -> void:
	current_damage = value

func revert_damage() -> void:
	current_damage = initial_damage
