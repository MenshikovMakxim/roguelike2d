extends Character
class_name Enemy

@export var player : NodePath
@onready var target: Node2D 
@export var can_attack: bool = true
@onready var attack_box = $AttackBox


func get_player():
	target = get_node_or_null(player)
	return target


func disable():
	super()
	attack_box.set_deferred("monitoring", false)
	attack_box.set_deferred("monitorable", false)
	hp_bar.hide()

func _ready():
	super()
	hp_bar = $ProgressBar
	hp_bar.max_value = health
	hp_bar.value = hp_bar.max_value
	fsm.change_to("Chase")
	default_state = "Chase"


func take_damage(amount):
	super(amount)
	hp_bar.value = health


func do_attack():
	Global.emit_signal("attack_player", attack)


func _on_attack_box_body_entered(_body: Character) -> void:
	if can_attack and is_alive():
		fsm.change_to("Attack")


func _on_attack_box_body_exited(_body: Character) -> void:
	if is_alive():
		to_default_state()
