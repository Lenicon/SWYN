#extends CharacterComponent
#
#@export var gravity_component:GravityComponent
#
#@onready var graphics:Node2D = $Graphics
#@onready var head:Sprite2D = $Graphics/Player/Head
#@onready var body:Sprite2D = $Graphics/Player/Body
#@onready var player_graphics:Node2D = $Graphics/Player
#
#
#
### Main Functions #################################################
#func _ready() -> void:
	#set_color_beef()
	#if SceneManager.active:
		#global_position = SceneManager.player_pos
		#direction = SceneManager.player_direction
		#graphics.scale.x = direction
		#if SceneManager.player_jump_on_enter:
			#velocity.y = jump_velocity
		#SceneManager.active = false
#
#func _physics_process(delta:float) -> void:
	#if jumps != max_jumps and (is_on_floor() or jump_buffer_active):
		#jumps = max_jumps
	#
	#handle_knockback(delta)
#
#
#
### Color Functions #################################################
#func set_color_beef() -> void:
	#set_color(GameData.get_beef_color())
#func set_color(color:Color) -> void:
	#default_color = color
	#player_graphics.modulate = color
#
#
#
### Dash Functions #################################################
#@onready var dash_cooldown_timer:Timer = $DashCooldown
#var can_dash:bool = true
#func _on_dash_cooldown_timeout() -> void:
	#if is_on_floor():
		#can_dash = true
#
#func reset_dash() -> void:
	#dash_cooldown_timer.stop()
	#can_dash = true
#
#
#
### Set Invulnerability #################################################
#@export var invul_color:Color = Color("#abc789")
#func set_invul(yes:bool)->void:
	#hurtbox_component.active = !yes
	#if yes: set_color(invul_color)
	#else: set_color_beef()
#
#
#
### Dashing ##################################################
#func handle_dash() -> void:
	#if Input.is_action_just_pressed("dash") and can_dash:
		#var omnidir:Vector2 = Input.get_vector("left", "right", "up", "down").normalized()
		#
		#if omnidir.y > 0 and is_on_floor():
			#state_machine.transition_to_next_state("Dash")
		#else:
			#state_machine.transition_to_next_state("Dash", {"direction":omnidir})
#
#
#
### Horizontal Movement #################################################
#var can_move:bool = true
#var direction:int = 1
#var x_input:float
#@export var acceleration:float = 5.0
#@export var friction:float = 15.0
#@export var speed:float = 160
#
#func handle_horizontal_movement(delta:float) -> void:
	#if not can_move: return
	#x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	#var velocity_weight: float = delta * (acceleration if x_input else friction)
	#velocity.x = lerp(velocity.x, x_input * speed, velocity_weight)
	#if x_input!=0 and direction!=x_input:direction = roundi(x_input)
#
#
#
### Spoon Attack #################################################
#@onready var spoon_attack_cooldown_timer:Timer = $SpoonAttackCooldown
#@onready var spoon_player:AnimationPlayer = $SpoonAnimationPlayer
#var can_spoon_attack:bool = true
#
#func handle_spoon_attack()->void:
	#if Input.is_action_just_pressed("attack") and can_spoon_attack:
		#if Input.is_action_pressed("up"):
			#spoon_player.play("UpAttack")
		#elif Input.is_action_pressed("down") and not is_on_floor():
			#spoon_player.play("DownAttack")
		#else:
			#spoon_player.play("SideAttack")
		#
		#if is_on_floor() and get_traveled_animation() == "Idle":
				#travel_animation("Halt")
		#
		#can_spoon_attack = false
		#spoon_attack_cooldown_timer.start()
#
#func _on_spoon_attack_cooldown_timeout():
	#can_spoon_attack = true
#
#
#
### Advance Jumping ################################################
#@export var jump_velocity: float = 400
#@export var max_jumps:int = 2
#@export var min_jumps:int = 1
#var jump_buffer_active:bool = false
#var jumps:int = max_jumps
#
#func jump() -> void:
	#if jumps > 0:
		#velocity.y = -jump_velocity
#
#func handle_variable_jump_height(jump_released:bool) -> void:
	#if jump_released and not gravity_component.is_falling and jumps > 0:
		#velocity.y = -(jump_velocity)/4
	#if jump_released:
		#jumps -= 1
#
#
#
### Handle Knockback #################################################
#func handle_knockback(delta:float) -> void:
	#if hitbox_component.has_overlapping_bodies():
		#if spoon_player.current_animation == "DownAttack":
			#jumps = min_jumps
			#reset_dash()
			#velocity.y = -170
		#if spoon_player.current_animation == "UpAttack":
			#velocity.y = 300
		#if spoon_player.current_animation == "SideAttack":
			#velocity.x += 20 * (-direction)
#
#
#
### Signals #############################################
#func _on_hurt_box_component_received_damage(_damage:int) -> void:
	#get_parent().camera.screen_shake(10, 0.1)
#
#func _on_hit_box_component_body_entered(body:PhysicsBody2D):
	#if body.is_in_group("Bounceable"):
		#if spoon_player.current_animation == "SideAttack": 
			#body.velocity.x = body.x_knockback_strength * direction
			#body.velocity.y = 0
		#if spoon_player.current_animation == "DownAttack":
			#body.velocity.x = body.y_knockback_strength
		#if spoon_player.current_animation == "UpAttack": 
			#body.velocity.y = -body.y_knockback_strength
