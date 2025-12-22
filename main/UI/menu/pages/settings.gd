extends Control

var in_game = false
@onready var texture = $TextureRect
@onready var music_sounds = $MarginContainer/HBoxContainer/VBoxContainer/Sounds/Music/HSlider
@onready var effects_sounds = $MarginContainer/HBoxContainer/VBoxContainer/Sounds/Effects/HSlider
@onready var value_music = $MarginContainer/HBoxContainer/VBoxContainer/Sounds/Music/value
@onready var value_effects = $MarginContainer/HBoxContainer/VBoxContainer/Sounds/Effects/value2
@onready var chek_box = $MarginContainer/HBoxContainer/VBoxContainer/Graphic/HBoxContainer/CheckBox
@onready var spawn_time = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer3/Seconds/HSlider
@onready var value_spawn_time = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer3/Seconds/value3
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	chek_box.button_pressed = Global.smooth
	music_sounds.value = Global.k_volume
	effects_sounds.value = Global.k_volume_effects
	spawn_time.value = Global.spawn_timer
	value_spawn_time.text = str(Global.spawn_timer)
	value_music.text = str(Global.k_volume*100)
	value_effects.text = str(Global.k_volume_effects*100)


func _on_h_slider_value_changed1(value: float) -> void:
	value_music.text = str(value*100)
	Global.k_volume = value
	Global.change_volume.emit()


func _on_h_slider_value_changed2(value: float) -> void:
	value_effects.text = str(value*100)
	Global.k_volume_effects = value
	Global.change_volume.emit()


func _on_back_pressed() -> void:
	if in_game:
		visible = false
	else:
		Global.go_to("menu")


func _on_check_box_toggled(toggled_on: bool) -> void:
	Global.smooth = toggled_on
	Global.smooth_changed.emit()


func _on_h_slider_value_changed3(value: float) -> void:
	value_spawn_time.text = str(value)
	Global.spawn_timer = value
	Global.change_spawn_timer.emit()
