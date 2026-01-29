extends StaticBody2D
class_name NPC

@onready var collector : Area2D = $Area2D
@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var timer : Timer = $Timer
@onready var label : Label = $Label
@onready var upgrade_offer := $UpOffer
var _entered : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if upgrade_offer:
		upgrade_offer.hide()
	
	if label:
		label.hide()
	
	if animation:
		animation.play("idle")


func _use() -> void:
	print(get_tree().paused)
	if upgrade_offer.visible:
		get_tree().paused = false
		upgrade_offer.hide()
	else:
		get_tree().paused = true
		upgrade_offer.show()


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
