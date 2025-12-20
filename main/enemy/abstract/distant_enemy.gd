extends Enemy
class_name DistantEnemy

@export var distant_to_attack : float = 200
@onready var bullet : PackedScene = load("res://main/bullets/enemy_bullet.tscn")
@onready var shoot_point : Marker2D = $Face/Marker2D


func _ready():
	super()


func do_far_attack():
	var bull = bullet.instantiate()
	get_tree().current_scene.add_child(bull)
	bull.set_damage(attack)
	bull.global_position = shoot_point.global_position
	
	var dir = (get_player().global_position - shoot_point.global_position).normalized()
	
	var spread_deg = 3.0  
	var spread_rad = deg_to_rad(randf_range(-spread_deg, spread_deg))

	var final_angle = dir.angle() + spread_rad
	var final_dir = Vector2.RIGHT.rotated(final_angle)

	bull.direction = final_dir
	bull.rotation = final_angle


func _process(delta: float) -> void:
	super(delta)
	if is_alive():
		if is_attack_range():
			fsm.change_to("FarAttack")
		else:
			to_default_state()


func calc_distant():
	if get_player():
		return position.distance_to(get_player().global_position)


func is_attack_range() -> bool:
	if calc_distant():
		return calc_distant() <= distant_to_attack
	else:
		return false
