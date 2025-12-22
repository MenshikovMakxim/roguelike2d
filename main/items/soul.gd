extends Area2D
class_name Soul


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	jump()
	flash_light()
	$AnimatedSprite2D.play("idle")


func disable():
	$CollisionShape2D.set_deferred("disabled", true)


func flash_light(duration := 0.5, start_energy := 1.0):
	var light := $PointLight2D
	light.energy = start_energy
	
	var tween := create_tween()
	tween.tween_property(light, "energy", 0.0, duration)


func jump():
	var offset := randf_range(5, 12)  
	var time := randf_range(0.9, 1.6) 

	var t := create_tween()
	t.tween_property(self, "position:y", position.y - offset, time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	t.tween_property(self, "position:y", position.y, time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	t.tween_callback(func(): jump())


func delete():
	disable()
	Global.take_soul.emit()
	queue_free()


func _on_body_entered(body: Character) -> void:
	if body is Hero:
		body.fsm.change_to("Collect")
		var tween := create_tween()
		tween.tween_property(self, "modulate:a", 0.0, 0.5)
		tween.tween_callback(delete)

	if body is Enemy:
		disable()
		$AnimatedSprite2D.play("free")


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "free":
		queue_free()
