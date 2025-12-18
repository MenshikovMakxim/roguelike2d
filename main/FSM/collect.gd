extends State


func _ready() -> void:
	pass


func physics_update(_delta):
	if actor is Hero:
		Global.move(actor)


func enter():
	actor.play_anim("collect", collect)


func collect():
	actor.play_effects("collect")
	actor.play_sound("collect")
		
