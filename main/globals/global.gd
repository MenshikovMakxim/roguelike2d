extends Node

##signals

signal damage_taken(amount)
signal attack_player(damage)
signal player_dead

##stats

var hp = 200
var speed = 200
var attack = 20

##router

var scens = {
	"menu": "res://main/UI/menu/menu.tscn",
	"game": "res://main/game.tscn",
	"credits": "res://main/UI/credits/Credits.tscn"
}

func go_to(_name: String):
	var scene = scens[_name]
	get_tree().change_scene_to_file(scene)
