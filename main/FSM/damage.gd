extends State


func enter():
	actor.to_act("damage", attack_finished)

func physics_update(_delta):
	if actor is Hero:
		Global.move(actor)


func attack_finished():
	if actor.is_alive():
		actor.to_default_state()
	else:
		actor.fsm.change_to("Die")
