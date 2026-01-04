extends State
class_name AttackState


func enter():
	actor.play_effects("attack")
	actor.play_anim("attack")
	actor.anim.connect("frame_changed", Callable(self, "attack"))


func physics_update(_delta):
	if actor is Hero:
		Global.move(actor)


func attack():
	if actor.anim.frame in actor.attack_frames:
		actor.do_attack()
		actor.play_sound("attack")


func exit():
	actor.anim.disconnect("frame_changed", Callable(self, "attack"))
