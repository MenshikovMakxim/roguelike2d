extends State

func enter():
	actor.velocity = Vector2.ZERO
	
	if actor.is_in_group("player"):
		Eventbus.emit_signal("player_dead")
		
	actor.anim.play("die")
	await actor.anim.animation_finished
	delete_actor()
	
func delete_actor():
	actor.queue_free()
