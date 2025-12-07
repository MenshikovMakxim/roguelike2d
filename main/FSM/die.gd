extends State

func enter():
	actor.anim.connect("frame_changed", Callable(self, "sound"))
	actor.velocity = Vector2.ZERO
	actor.disable()
	
	#actor.play_effects("die")
	#await actor.anim.animation_finished
	
	actor.anim.play("die")
	actor.play_anim("die", delete_actor)
	
	


func sound():
	if actor.anim.frame == actor.die_frame:
		actor.shadow.hide()
		actor.play_sound("die", 10)


func delete_actor():
	
	if actor is Hero:
		Global.emit_signal("player_dead")
		
	Global.spawn_soul(actor.position)
	actor.queue_free()
	actor.audio.stop()


func exit():
	actor.anim.disconnect("frame_changed", Callable(self, "sound"))
