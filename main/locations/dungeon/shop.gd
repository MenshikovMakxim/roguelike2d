extends Node2D

@onready var hero = load("res://main/character/hero.tscn").instantiate()
@onready var spawn_point = $Marker2D
@onready var ground = $Ground
@onready var teleport = $Marker2D/Area2D
@onready var action = $Marker2D/Label
var _entered : bool = false


func _ready() -> void:
	prepare_hero()
	action.text = "Press E"
	action.hide()


func _input(event) -> void:
	if _entered:
		if event.is_action_pressed("ui_use"):
			_teleport()


func _teleport() -> void:
	Global.go_to("game")


func prepare_hero():
	add_child(hero)
	hero.to_act("spawn")
	hero.position = spawn_point.global_position
	hero.set_limits_from_layer(ground)


func _on_area_2d_body_exited(_body: Node2D) -> void:
	_entered = false
	action.hide()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	_entered = true
	action.show()
