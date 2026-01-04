extends State

var shooting : bool = false

func enter():
	actor.to_act("idle")


func physics_update(_delta):
	Global.move(actor)
	
	if shooting:
		actor.fsm.change_to("Attack")


func _input(event):
	if event.is_action_pressed("shot"):
		shooting = true
	if event.is_action_released("shot"):
		shooting = false
