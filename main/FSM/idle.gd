extends State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter():
	actor.velocity = Vector2.ZERO
	actor.anim.play("idle")
	actor.play_effects("idle")
