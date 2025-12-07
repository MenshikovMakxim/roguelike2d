extends Control


func _ready() -> void:
	$VBoxContainer.hide()
	
	$SoundManager.play_sound("menu_soundtrack")
	var tween = create_tween()
	$TextureRect.modulate.a = 0.0
	tween.tween_property($TextureRect, "modulate:a", 1.0, 4.0) # 1 секунда
	
	await tween.finished 
	$VBoxContainer.show()
	$VBoxContainer/Label.text = "You are collected " + str(Global.souls) + " souls!"


func _on_retry_pressed() -> void:
	Global.go_to("game")


func _on_menu_pressed() -> void:
	Global.go_to("menu")
