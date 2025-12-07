extends State

#@onready var player = false


func enter():
	#if actor is Hero:
		#player = true

	if actor.has_method("take_damage"):
		actor.play_anim("damage", attack_finished)
		actor.play_sound("damage")
		actor.play_effects("damage")


func attack_finished():
	if actor.health > 0:
		actor.to_default_state()
	else:
		actor.fsm.change_to("Die")
