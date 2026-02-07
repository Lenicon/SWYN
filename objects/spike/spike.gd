extends Area2D

@export var respawn_scene:String = "Part1/Grassy_1"
@onready var op:Node2D = owner
var blipped:bool = false
func _on_body_entered(body:Node2D)->void:
	if body.is_in_group("Pig") and !blipped:
		blipped = false
		Data.save["deaths"] += 1
		
		if (Data.save["deaths"] >= 1 and Data.save["deaths"] <= 6 and Data.save["part"]==1) or (Data.save["deaths"] == 10):
			Voice.talk("death"+str(Data.save["deaths"]),1)
		
		op.pig.disable_movement()
		op.pig.die()
