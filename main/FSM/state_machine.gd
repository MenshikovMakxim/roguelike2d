extends Node

var current_state: Node
var default: String
var states = {}

func init(_actor):
	for child in get_children():
		child.actor = _actor
		states[child.name] = child

func change_to(state_name: String):
	if not default:
		default = state_name
	if current_state:
		current_state.exit()
	current_state = states[state_name]
	current_state.enter()

func physics_update(delta):
	if current_state:
		current_state.physics_update(delta)

func to_default():
	change_to(default)
