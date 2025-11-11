extends State

var target: Node2D

func enter(msg = {}):
	target = actor.get_player()

func physics_update(delta):
	var direction = (target.global_position - actor.global_position).normalized()
	actor.velocity = direction * actor.speed
	actor.move_and_slide()
	actor.play_anim("chase")

	if actor.velocity.x != 0:
		actor.face.scale.x = -1 if actor.velocity.x < 0 else 1
