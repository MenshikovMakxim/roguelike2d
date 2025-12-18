extends Node2D

@onready var hero = load("res://main/character/hero.tscn").instantiate()
@onready var spawn_point = $Marker2D
@onready var ground = $Ground


func _ready() -> void:
	prepare_hero()


func prepare_hero():
	add_child(hero)
	hero.to_act("spawn")
	hero.position = spawn_point.global_position
	hero.set_limits_from_layer(ground)
