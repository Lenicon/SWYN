extends CharacterBody2D

@export var pig:CharacterComponent = null
@export var gravity_component:GravityComponent
@onready var s:Sprite2D = $Sprite2D
@onready var a:AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	if pig == null:
		pig = owner.pig


@export var speed:float = 300
var target_x_position:float
var is_ordered:bool = false

@export var will_listen:bool = true

func set_listen(x:bool)->void:
	will_listen = x


func _process(delta:float)->void:
	if is_ordered and will_listen:
		var direction_x = sign(target_x_position - global_position.x)
		velocity.x = direction_x * speed
		s.rotation += direction_x * (speed/5) * delta
		
		if abs(target_x_position - global_position.x) < 5.0:
			velocity.x = 0
			is_ordered = false
			a.stop()
	
	gravity_component.handle_gravity(self, delta)
	move_and_slide()

func order(x:float)->void:
	if will_listen:
		a.play()
		target_x_position = x
		is_ordered = true
