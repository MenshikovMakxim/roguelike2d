extends MarginContainer

@onready var bar : ProgressBar = $VBoxContainer/ProgressBar
@onready var hp_label : Label = $VBoxContainer/ProgressBar/Label

func setup(_value) -> void:
	bar.max_value = _value
	bar.value = _value
	hp_label.text = str(_value)


func update(_value) -> void:
	bar.value = _value
	hp_label.text = str(_value)
	if _value <= 0:
		hp_label.text = str(0)
	else:
		hp_label.text = str(_value)
