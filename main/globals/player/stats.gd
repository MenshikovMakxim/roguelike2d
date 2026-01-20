extends Node

var current_stats: StatsDef = preload("res://data/player_stats/resources/base_stats.tres")
var unlocked_abilities: Array[Ability] = []

var hp = current_stats.max_health
var speed = current_stats.speed
var attack = current_stats.damage
var souls = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func upgrade(new_upgrade: Upgrade) -> void:
	new_upgrade.apply(current_stats)
	to_def()
	
	
func to_def():
	hp = current_stats.max_health
	speed = current_stats.speed
	attack = current_stats.damage
	souls = 0
