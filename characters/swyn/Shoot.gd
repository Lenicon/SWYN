extends State

@export var spot:Marker2D
@export var cooldown:Timer
@export var ammo: int = 3
@export var max_ammo:int = 3

@export var knockback:float = 10000
#@export var knockback_cooldown:float = 10

#var kc:float = knockback_cooldown

var type:int = Data.save["syn"]["weapon"]
var bullet:BulletComponent

var ass:int = 1
func enter(_previous_state_path: String, _data : Dictionary = {}) -> void:
	owner.play_animation("idle")
	await get_tree().create_timer(0.01).timeout
	#ass -= 1
	
	#kc = knockback_cooldown
	if (Data.save["syn"]["weapon"] == Data.WEAPON.CANNON):
		bullet = load("res://objects/cannonball/Cannonball.tscn").instantiate()
		bullet.global_position = spot.global_position
		bullet.direction = owner.direction
		owner.owner.add_child(bullet)
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
