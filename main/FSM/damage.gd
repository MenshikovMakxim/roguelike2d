extends State

@onready var player = false

#func _ready() -> void:
	##Eventbus.connect("animation_finished", Callable(self, "attack_finished"))
	#pass
func enter():
	if actor.is_in_group("player"):
		player = true

	if actor.has_method("take_damage"):
		actor.play_anim("damage", attack_finished)

func attack_finished():
	actor.to_default_state()
	#if player:
		#actor.fsm.change_to("Move")
	#else:
		#actor.fsm.change_to("Chase")
