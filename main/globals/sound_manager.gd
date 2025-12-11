extends Node

@onready var player : AudioStreamPlayer 

func _ready() -> void:
	Global.connect("change_volume", Callable(self, "change_volume"))

func play_sound(_name: String, _volume: int = 0):
	player = AudioStreamPlayer.new()
	player.stream = all_sounds[_name]
	player.volume_db = Global.calc_volume_music()
	add_child(player)
	player.play()

func change_volume():
	player.volume_db = Global.calc_volume_music()


func stop_sound():
	if player:
		player.stop()


##sounds
var all_sounds = {
	"fire_born": preload("res://assets/sounds/fire/fire-burning.ogg"),
	"game_soundtrack": preload("res://assets/sounds/enemy/soundtrack/fires-of-anticipation_91140.ogg"),
	"menu_soundtrack": preload("res://assets/sounds/enemy/soundtrack/Factory.ogg")
}
