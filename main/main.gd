extends Node2D

@onready var mobs : Array[PackedScene]
@onready var spawn_path : PathFollow2D

func _ready() -> void:
	Global.connect("player_dead", Callable(self, "stop_spawn"))
	mobs.append(load("res://main/enemy/NightWarrior.tscn"))
	mobs.append(load("res://main/enemy/slime.tscn"))


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		#get_tree().change_scene_to_file("res://main/main.tscn")
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
