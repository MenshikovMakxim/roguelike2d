extends Node
##variables

@onready var sound_manager = preload("res://main/globals/SoundManager.tscn").instantiate()
@onready var pause_scene = load("res://main/UI/menu/pages/pause.tscn")
##signals

signal damage_taken(amount)
signal attack_player(damage)
signal player_dead
signal die_enemy
signal take_soul
signal change_volume
signal change_spawn_timer
signal smooth_changed
signal start_game
signal menu


func _ready() -> void:
	add_child(sound_manager)

	self.connect("player_dead",  Callable(self, "go_to").bind("lose"))
	self.connect("take_soul", Callable(self, "add_soul"))
	self.connect("start_game", Callable(self, "stop_menu"))
	self.connect("menu", Callable(self, "start_menu"))


##stats of hero

var hp = 200
var speed = 170
var attack = 50
var souls = 0

##sound volume [0,1]

var k_volume = 0.5
var k_volume_effects = 0.5
var smooth = false

##game

var spawn_timer = 4



func switch_filter():
	if smooth:
		return CanvasItem.TEXTURE_FILTER_LINEAR
	else:
		return CanvasItem.TEXTURE_FILTER_NEAREST


func calc_volume_music():
	return linear_to_db(Global.k_volume)

func calc_volume_effects():
	return linear_to_db(Global.k_volume_effects)

func stop_menu():
	to_def()
	sound_manager.stop_sound()

func start_menu():
	sound_manager.play_sound("menu_soundtrack")

##router

var scens = {
	"menu": "res://main/UI/menu/menu.tscn",
	"game": "res://main/game.tscn",
	"lose": "res://main/UI/Lose_screen.tscn",
	"credits": "res://main/UI/menu/pages/credits.tscn",
	"settings": "res://main/UI/menu/pages/settings.tscn",
	"pause": "res://main/UI/menu/pause.tscn",
	"tutorial": "res://main/UI/menu/pages/tutorial.tscn"
}

func go_to(_name: String):
	var scene = scens[_name]
	get_tree().change_scene_to_file(scene)

## souls

func spawn_soul(position, parent):
	var soul_scene = preload("res://main/items/soul.tscn")
	var soul := soul_scene.instantiate()
	soul.position = position
	parent.add_child(soul)


func to_def():
	hp = 200
	speed = 170
	attack = 50
	souls = 0


func add_soul():
	souls += 1


func move(_actor : Hero):
	var dir = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1

	dir = dir.normalized()
	_actor.velocity = dir * _actor.speed
	_actor.move_and_slide()

	# Поворот спрайта
	if dir.x != 0:
		_actor.get_node("Face").scale.x = -1 if dir.x < 0 else 1
