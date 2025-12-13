extends Node2D

@onready var timer = $Timer
@onready var counter = $Label

var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func start(_second : float):
	time = _second
	timer.start()


func _render_label():
	modulate.a = 1
	
	counter.text = str(int(time))
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.7)


func _on_timer_timeout() -> void:
	time -= 1
	if time:
		_render_label()
	else:
		queue_free()
