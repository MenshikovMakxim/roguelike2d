extends CanvasLayer

@onready var pause_menu = $MarginContainer
@onready var settings_menu = $SettingsPage


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#visible = false
	settings_menu.hide_background()
	settings_menu.visible = false
	settings_menu.in_game = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not settings_menu.visible:
		pause_menu.visible = true


func _on_continue_pressed() -> void:
	get_parent().pause(false)
	queue_free()


func _on_settings_pressed() -> void:
	pause_menu.visible = false
	settings_menu.visible = true


func _on_menu_pressed() -> void:
	get_parent().pause(false)
	Global.menu.emit()
	Global.go_to("menu")


func _on_exit_pressed() -> void:
	get_tree().quit()
