extends AttackState


func attack():
	for attack_frame in actor.attack_frames:
		if actor.anim.frame == attack_frame:
			actor.do_far_attack()
			actor.play_sound("attack")


func physics_update(_delta):
	if not actor.is_attack_range():
		actor.fsm.change_to("Chase")
