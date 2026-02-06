class_name UIComponent
extends CanvasLayer

@export var pig:CharacterComponent
@onready var lc:HBoxContainer = $Lives
var prev_hp:int
var lives:Array

func _ready():
	prev_hp = Data.save["health"]
	pig.health_component.health_decreased.connect(_on_health_decreased)
	pig.health_component.health_increased.connect(_on_health_increased)
	update_hp()

func update_hp()->void:
	if (prev_hp > Data.save["health"]): clear_hp()
	
	var lccc:int = lc.get_child_count()
	for i in range(lccc, Data.save["health"]):
		var lf = TextureRect.new()
		lf.texture = load("res://objects/truffle/truffle1.png")
		lives.append(lf)
		lc.add_child(lf)
	prev_hp = Data.save["health"]
	
func clear_hp()->void:
	lives.clear()
	for i in lives.size():
		lc.remove_child(lc.get_child(i))

func _on_health_decreased(amount:int)->void:
	var h = Data.save["health"]
	for i in range(h-1, h-amount-1):
		lives[i].visible = false

func _on_health_increased(amount:int)->void:
	var h = Data.save["health"]
	for i in range(h-1, h-amount-1):
		lives[i].visible = true
