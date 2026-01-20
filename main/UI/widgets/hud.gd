extends CanvasLayer

@onready var hp_bar = $MarginContainer/VBoxContainer/HpBar

func _ready() -> void:
	Stats.to_def()
	Global.connect("take_soul", Callable(self, "update_soul_bar"))
	hp_bar.setup(Stats.hp)


func update_soul_bar():
	$MarginContainer/VBoxContainer/HBoxContainer/Label.text = str(Global.souls)


func update(_value):
	Stats.hp = _value
	hp_bar.update(_value)
