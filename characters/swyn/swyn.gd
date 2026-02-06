extends CharacterComponent

@export var body_shape: Node2D
@onready var truffle_noise:AudioStreamPlayer2D = $TruffleNoise

func _ready():
	health_component.set_health(Data.save["health"])
	update_syn()

func disable_movement()->void:
	can_move = false
	velocity = Vector2.ZERO

func enable_movement()->void:
	can_move = true

func set_health(amount:int)->void:
	health_component.set_health(amount)
	Data.save["health"] = amount

## SYN ###############################################
@onready var syn:Sprite2D = $Polygons/Syn
@onready var syn_cannon:Sprite2D = $Polygons/SynCannon
@export var syn_speed:float = 800 

func update_syn():
	syn.visible = Data.save["syn"]["active"]
	syn_cannon.visible = (Data.save["syn"]["weapon"] != Data.WEAPON.NONE and syn.visible)
	speed = syn_speed if Data.save["syn"]["active"] else initial_speed
	

## Horizontal Movement #################################################
var can_move:bool = true
var x_input:float
@export var acceleration:float = 5.0
@export var friction:float = 15.0
@export var initial_speed: float = 500
@export var speed:float = 500

func handle_horizontal_movement(delta:float) -> void:
	body_shape.scale.x = direction
	
	if not can_move: return
	x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var velocity_weight: float = delta * (acceleration if x_input else friction)
	velocity.x = lerp(velocity.x, x_input * speed, velocity_weight)
	if x_input!=0 and direction!=x_input:direction = roundi(x_input)


## Advance Jumping ################################################
@export var jump_height : float = 400.0 # Pixels
@export var time_to_peak : float = 0.1 # Seconds

@onready var jump_velocity : float = -((2.0 * jump_height) / time_to_peak)

#@export var jump_velocity: float = 400
var max_jumps:int = Data.save["jumps"]
@export var min_jumps:int = 1
var jump_buffer_active:bool = false
var jumps:int = max_jumps
@onready var oink:AudioStreamPlayer2D = $Oink

func jump() -> void:
	if jumps > 0 and can_move:
		Voice.noise(oink, "oink")
		velocity.y = jump_velocity

func handle_variable_jump_height(jump_released:bool) -> void:
	if jump_released and not gravity_component.is_falling and jumps > 0:
		velocity.y = jump_velocity/4
	if jump_released:
		jumps -= 1
