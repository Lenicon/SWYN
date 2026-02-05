##################
## DO NOT MODIFY #
##################

####### DOCUMENTATION ######
## ADD A CollisionShape2D UNDER THIS COMPONENT TO USE THIS.
## MULTIPLE CollisionShape2D CAN BE ADDED UNDER THIS COMPONENT.
##
## This class receives damage through area collision from HitBoxComponent
## It decreases the current in HealthComponent accordingly
##
## received_damage               Signal to check if Object receives damage
## 


class_name HurtBoxComponent
extends Area2D

signal received_damage(damage:int)

@export var health:HealthComponent
@export var hurtbox_active:bool = true

func _ready() -> void:
	if (owner.get("health_component") != null and health==null): health = owner.health
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox:Area2D) -> void:
	if hitbox!=null and hitbox is HitBoxComponent:
		damage(hitbox)

func damage(hitbox:Area2D) -> void:
	if hurtbox_active == true:
		#print("%s : %s" % [owner.name, health.health])
		received_damage.emit(hitbox.damage)
		health.decrease(hitbox.damage)
	
