extends Node

var player : AudioStreamPlayer


func play_sound(_name: String, _volume: int = 0):
	player = AudioStreamPlayer.new()
	player.stream = all_sounds[_name]
	player.volume_db = _volume
	add_child(player)
	player.play()


func stop_sound():
	if player:
		player.stop()

##sounds
var all_sounds = {
	"fire_born": preload("res://assets/sounds/fire/fire-burning.ogg"),
	"game_soundtrack": preload("res://assets/sounds/enemy/soundtrack/fires-of-anticipation_91140.ogg"),
	"menu_soundtrack": preload("res://assets/sounds/enemy/soundtrack/Factory.ogg")
}
