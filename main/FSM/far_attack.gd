extends AttackState

func attack():
	if actor.anim.frame == actor.attack_frame:
		actor.do_far_attack()
		actor.play_sound("attack")
