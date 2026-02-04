extends CharacterComponent

@export var body_shape: Node2D

func _ready() -> void:
	pass


## Horizontal Movement #################################################
var can_move:bool = true
var direction:int = 1
var x_input:float
@export var acceleration:float = 5.0
@export var friction:float = 15.0
@export var speed:float = 160

func handle_horizontal_movement(delta:float) -> void:
	body_shape.scale.x = direction
	
	if not can_move: return
	x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var velocity_weight: float = delta * (acceleration if x_input else friction)
	velocity.x = lerp(velocity.x, x_input * speed, velocity_weight)
	if x_input!=0 and direction!=x_input:direction = roundi(x_input)


## Advance Jumping ################################################
@export var jump_velocity: float = 400
@export var max_jumps:int = 2
@export var min_jumps:int = 1
var jump_buffer_active:bool = false
var jumps:int = max_jumps

func jump() -> void:
	if jumps > 0:
		velocity.y = -jump_velocity

func handle_variable_jump_height(jump_released:bool) -> void:
	if jump_released and not gravity_component.is_falling and jumps > 0:
		velocity.y = -(jump_velocity)/4
	if jump_released:
		jumps -= 1
