## This is the CharacterComponent
## All Characters will have this Component

############ IMPORTANT #############
##  DO NOT MODIFY                  #
##  EXTEND THIS CLASS TO USE IT    #
####################################

class_name CharacterComponent
extends CharacterBody2D

@export_subgroup("Components")
#@export var default_color:Color
@export var animation_player:AnimationPlayer = null
#@export var animation_tree:AnimationTree = null
@export var state_machine:StateMachine  ## REQUIRED
@export var health_component:HealthComponent
@export var hurtbox_component:HurtBoxComponent
@export var hitbox_component:HitBoxComponent
@export var gravity_component:GravityComponent
var direction:int = 1
#@export var hitbox_component:HitBoxComponent

#@export var movement_component:MovementComponent

## Changing of Animations
func play_animation(anim:String) -> void:
	if animation_player!=null:
		if !animation_player.get_animation(anim):
			printerr(name+": Animation \"" + anim + "\" does not exist.")
			return
		if (animation_player.current_animation != anim):
			animation_player.call_deferred("play", anim)

#func travel_animation(anim:String) -> void:
	#if animation_tree!= null:
		#if !animation_tree.get_animation(anim):
			#printerr(name+": Animation \"" + anim + "\" does not exist.")
		#else:
			#if get_traveled_animation() != anim:
				#animation_tree.get("parameters/playback").travel(anim)
#
#func get_traveled_animation()->StringName:
	#return animation_tree.get("parameters/playback").get_current_node()
