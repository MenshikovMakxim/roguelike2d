extends NPC

func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play("eat")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "eat":
		$AnimatedSprite2D.play("idle")
		$Timer.start()


func _use() -> void:
	print("Meaw!")
