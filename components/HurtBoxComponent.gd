
class_name HurtBoxComponent
extends Area2D

signal received_damage(damage:int)

#@export var death_reason: String = ""
@export var health: HealthComponent
@export var hurtbox_active: bool = true

func _ready() -> void:
	if (owner.get("health_component") != null and health==null): health = owner.health
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox:Area2D) -> void:
	if hitbox!=null and hitbox is HitBoxComponent:
		damage(hitbox)

var last_hitter:String
func damage(hitbox:HitBoxComponent) -> void:
	if hurtbox_active == true:
		#print("%s : %s" % [owner.name, health.health])
		#death_reason = owner.name
		last_hitter = hitbox.hitter_name
		received_damage.emit(hitbox.current_damage)
		health.decrease(hitbox.current_damage)
	
