extends Node2D

var mobs = [
	load("res://main/enemy/night_warrior.tscn"),
	load("res://main/enemy/slime.tscn"),
	load("res://main/enemy/fire_worm.tscn"),
	load("res://main/enemy/skeleton.tscn")
]

@onready var hero = load("res://main/character/hero.tscn").instantiate()
@onready var music = $SoundManager
@onready var map = $Flat
@onready var spawn_point = $Marker2D
@onready var spawn_path = $Path2D/PathFollow2D

func _ready() -> void:
	prepare_game()
	Global.start_game.emit()
	Global.connect("smooth_changed", Callable(self, "change_filter"))
	Global.connect("player_dead", Callable(self, "stop_spawn"))
	Global.connect("change_spawn_timer", Callable(self, "change_timer"))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pause(true)


#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("ui_cancel"):
		#pause(true)


func rand_mob() -> PackedScene:
	return mobs.pick_random()


func _on_timer_timeout() -> void:
	prepare_mob()


func stop_spawn():
	$Timer.stop()
	queue_free()


func pause(paused : bool):
	get_tree().paused = paused
	if paused:
		add_child(Global.pause_scene.instantiate())


func change_filter():
	texture_filter = Global.switch_filter()

func change_timer():
	$Timer.wait_time = Global.spawn_timer

func prepare_hero():
	add_child(hero)
	hero.play_effects("spawn")
	hero.position = spawn_point.global_position
	hero.set_limits_from_layer(map.get_ground())
	
func prepare_mob():
	var mob = rand_mob().instantiate()
	mob.position = spawn_path.position
	mob.player = "../Hero"
	add_child(mob)

func prepare_game():
	music.play_sound("game_soundtrack")
	change_timer()
	change_filter()
	prepare_hero()
