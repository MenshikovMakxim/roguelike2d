extends Node2D

@onready var mobs : Array[PackedScene]
@onready var spawn_path : PathFollow2D

func _ready() -> void:
	mobs.append(load("res://main/enemy/NightWarrior.tscn"))
	mobs.append(load("res://main/enemy/slime.tscn"))

func rand_mob() -> PackedScene:
	return mobs.pick_random()


func _on_timer_timeout() -> void:
	spawn_path = $Path2D/PathFollow2D
	var mob = rand_mob().instantiate()
	mob.position = spawn_path.position
	mob.player = "../Hero"
	#mob.can_attack = false
	add_child(mob)
