extends Node

##signals

signal damage_taken(amount)
signal attack_player(damage)
signal player_dead


func _ready() -> void:
	self.connect("player_dead",  Callable(self, "go_to").bind("lose"))

##stats of hero

var hp = 200
var speed = 170
var attack = 40

##router

var scens = {
	"menu": "res://main/UI/menu/menu.tscn",
	"game": "res://main/game.tscn",
	"lose": "res://main/UI/Lose_screen.tscn",
	"credits": "res://main/UI/credits/Credits.tscn"
}

func go_to(_name: String):
	var scene = scens[_name]
	get_tree().change_scene_to_file(scene)
