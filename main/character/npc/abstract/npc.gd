extends StaticBody2D
class_name NPC

@onready var collector : Area2D = $Area2D
@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var timer : Timer = $Timer
@onready var label : Label = $Label
var _entered : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if label:
		label.hide()
	
	if animation:
		animation.play("idle")


func _use() -> void:
	pass


func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(_body: Node2D) -> void:
	_entered = true
	label.show()


func _on_area_2d_body_exited(_body: Node2D) -> void:
	_entered = false
	label.hide()


func _input(event) -> void:
	if _entered:
		if event.is_action_pressed("ui_use"):
			_use()
