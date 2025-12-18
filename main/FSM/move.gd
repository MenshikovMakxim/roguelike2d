extends State

func physics_update(_delta):
	Global.move(actor)
	actor.to_act("idle")

	if Input.is_action_pressed("mouse_0"):
		actor.fsm.change_to("Attack")
