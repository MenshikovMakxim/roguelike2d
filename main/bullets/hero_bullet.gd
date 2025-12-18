extends Bullet


func _on_body_entered(body: Node2D) -> void:
	fly = false
	play_sound("damage")
	
	if body is Enemy:
		_damage(body)
	else:
		_play_anim("destroy", queue_free)
