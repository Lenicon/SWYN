class_name StateMachine
extends Node

## If null, the first child State node is used as the default initial state.
@export var initial_state: State = null

## Holds the current active state.
## Automatically resolved at runtime based on:
##    initial_state (if set), otherwise
##    The first child State node.
@onready var state: State = (func get_initial_state() -> State: return initial_state if initial_state != null else get_child(0)).call()

## Connects all child states’ finished signals to transition_to_next_state.
func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(transition_to_next_state)

	await owner.ready
	state.enter("")

## Forwards input events to the active state.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

## Forwards frame updates to the active state.
func _process(delta: float) -> void:
	state.update(delta)

## Forwards physics updates to the active state.
func _physics_process(delta: float) -> void:
	state.physics_update(delta)

## Switches from the current state to the sp	ecified target state.
## target_state_path → Path of the target State node to transition to. (ex. Forward_Slash)
## data (optional) → Dictionary of additional data passed into the new state’s enter() function.
func transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.\nPlease read `RULES.txt` to follow proper conventions.")
		return

	var previous_state_path : String = state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)
