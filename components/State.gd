## Virtual base class for all states.
## Extend this class and override its methods to implement a state.
class_name State extends Node

# The state machine that the state is currently in
@onready var state_machine:StateMachine = get_parent()

## Emitted when the state finishes and wants to transition to another state.
#@warning_ignore("unused_signal")
signal finished(next_state_path: String, data: Dictionary)

## Emits the finished signal
func finish(next_state_path:String, data:Dictionary = {}):
	finished.emit(next_state_path, data)

## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	pass

## Called by the state machine on the engine's physics update tick.
func physics_update(_delta: float) -> void:
	pass

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_previous_state_path: String, _data : Dictionary = {}) -> void:
	pass

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	pass
