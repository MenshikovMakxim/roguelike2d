extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body is Character:
		body.fsm.change_to("Die")
	else:
		print("bullet_die")
		body.queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	area.queue_free()
	
