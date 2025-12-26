extends State

func physics_update(_delta):
	Global.move(actor)
	actor.to_act("idle")

	if Input.is_action_pressed("mouse_0") or Input.is_action_pressed("ui_accept"):
		actor.fsm.change_to("Attack")
