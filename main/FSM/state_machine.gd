extends Node
class_name FSM

var current_state : State
var states = {}

func init(_actor):
	for child in get_children():
		child.actor = _actor
		states[child.name] = child

func change_to(state_name: String) -> void:
	var new_state = states.get(state_name)
	
	if new_state == null:
		return
		
	if current_state == new_state:
		return 
		
	if current_state:
		current_state.exit()
		
	current_state = states[state_name]
	current_state.enter()

func physics_update(delta):
	if current_state:
		current_state.physics_update(delta)
