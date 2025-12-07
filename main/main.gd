extends Node2D

@onready var mobs : Array[PackedScene]
@onready var spawn_path : PathFollow2D
@onready var hero : PackedScene 

func _ready() -> void:
	Global.souls = 0
	Global.connect("player_dead", Callable(self, "stop_spawn"))
	mobs.append(load("res://main/enemy/NightWarrior.tscn"))
	mobs.append(load("res://main/enemy/slime.tscn"))
	mobs.append(load("res://main/enemy/FireWorm.tscn"))
	hero = load("res://main/character/hero.tscn")

	hero.instantiate().position = $Marker2D.global_position


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Global.go_to("menu")


func rand_mob() -> PackedScene:
	return mobs.pick_random()


func _on_timer_timeout() -> void:
	spawn_path = $Path2D/PathFollow2D
	var mob = rand_mob().instantiate()
	mob.position = spawn_path.position
	mob.player = "../Hero"
	#mob.can_attack = false
	add_child(mob)

func stop_spawn():
	$Timer.stop()
	
	queue_free()
