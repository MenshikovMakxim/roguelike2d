extends Control

@onready var hp : ProgressBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp.max_value = Global.hp
	hp.value = hp.max_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	hp.value = Global.hp
	if hp.value <= 0:
		return
