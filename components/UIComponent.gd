class_name UIComponent
extends CanvasLayer

@export var pig:CharacterComponent
@onready var lc:HBoxContainer = $Lives
var prev_hp:int
#var lives:Array

func _ready():
	prev_hp = Data.save["health"]
	pig.health_component.health_changed.connect(_on_health_changed)
	#pig.health_component.health_decreased.connect(_on_health_decreased)
	#pig.health_component.health_increased.connect(_on_health_increased)
	update_hp(prev_hp)

func _on_health_changed(_initial_health:int, current_health:int)->void:
	update_hp(current_health)

func update_hp(health:int)->void:
	#if prev_hp > health: clear_hp()
	
	clear_hp()
	var lccc:int = lc.get_child_count()
	for i in range(lccc, health):
		var lf = TextureRect.new()
		lf.texture = load("res://objects/truffle/truffle1.png")
		#lives.append(lf)
		lc.add_child(lf)
	prev_hp = health
	
func clear_hp()->void:
	#lives.clear()
	if lc.get_child_count()>0:
		for i in lc.get_child_count():
			lc.remove_child(lc.get_child(0))

#func _on_health_decreased(amount:int)->void:
	#var h = Data.save["health"]
	#for i in range(h-1, h-amount-1):
		#lives[i].visible = false
#
#func _on_health_increased(amount:int)->void:
	#var h = Data.save["health"]
	#for i in range(h-1, h-amount-1):
		#lives[i].visible = true
