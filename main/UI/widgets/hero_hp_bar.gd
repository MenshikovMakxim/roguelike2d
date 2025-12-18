extends MarginContainer

@onready var bar : ProgressBar = $VBoxContainer/ProgressBar


func setup(_value) -> void:
	bar.max_value = _value
	bar.value = _value


func update(_value) -> void:
	bar.value = _value
