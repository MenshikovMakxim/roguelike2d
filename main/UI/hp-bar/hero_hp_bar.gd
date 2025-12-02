extends MarginContainer

@onready var bar : ProgressBar = $VBoxContainer/ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bar.max_value = Global.hp
	bar.value = bar.max_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if bar.value <= 0:
		return
	bar.value = Global.hp
