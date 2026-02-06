extends State

@export var cooldown:Timer
@export var ammo: int = 3
@export var max_ammo:int = 3

@export var knockback:float = 10000
#@onready var bullet_scene = preload("res://objects/cannonball/Cannonball.tscn")
#@export var knockback_cooldown:float = 10

#var kc:float = knockback_cooldown

var type:int = Data.save["syn"]["weapon"]
#var bullet:BulletComponent
@export var shooting_component:ShootingComponent

var ass:int = 1
func enter(_previous_state_path: String, _data : Dictionary = {}) -> void:
	owner.play_animation("idle")
	await get_tree().create_timer(0.01).timeout
	#ass -= 1
	
	#kc = knockback_cooldown
	if (Data.save["syn"]["weapon"] == Data.WEAPON.CANNON):
		#var bullet = bullet_scene.instantiate()
		#bullet.global_position = spot.global_position
		#bullet.direction = owner.direction
		#owner.owner.add_child(bullet)
		shooting_component.shoot()
		ammo -= 1
		ass = 1
		cooldown.start()
		

func physics_update(_delta: float) -> void:
	match type:
		Data.WEAPON.CANNON:
			owner.velocity.y = 0
			owner.velocity.x += -owner.direction * knockback
			#kc -= 1
	
	#if (kc <= 0):
	if (owner.is_on_floor()):
		finish("FloorMovement")
	else:
		finish("AirMovement")

#func exit()->void:
	#can_shoot = true

func _on_shoot_cooldown_timeout():
	if ammo <= max_ammo:
		ammo += 1
