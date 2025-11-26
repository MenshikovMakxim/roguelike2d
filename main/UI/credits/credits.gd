extends Control


func _ready() -> void:
	$SoundManager.play_sound("menu_soundtrack")


func _on_autor_pressed() -> void:
	OS.shell_open("www.linkedin.com/in/максим-меньшиков-0aa21b338")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Global.go_to("menu")
