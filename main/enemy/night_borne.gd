extends Character
class_name Enemy

@export var player: NodePath
@onready var target: Node2D

func _init() -> void:
	super(300, 100, 50, 6)


func get_player():
	target = get_node_or_null(player)
	return target


func _ready():
	super()
	add_to_group("enemy")
	fsm.change_to("Chase")


func take_damage(amount):
	health -= amount
	fsm.change_to("Damage")


func do_attack():
	Eventbus.emit_signal("attack_player", attack)


func _on_attack_box_area_entered(_area: Area2D) -> void:
	fsm.change_to("Attack")


func _on_attack_box_area_exited(_area: Area2D) -> void:
	fsm.change_to("Chase")
