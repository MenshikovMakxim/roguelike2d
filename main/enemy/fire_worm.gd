extends Enemy

@export var distant_to_attack : float = 200
@onready var bullet : PackedScene = load("res://main/bullets/enemy_bullet.tscn")
@onready var shoot_point : Marker2D = $Face/Marker2D
var is_in_attack_range := false


func do_far_attack():
	var bull = bullet.instantiate()
	get_tree().current_scene.add_child(bull)
	bull.set_damage(25)
	bull.global_position = shoot_point.global_position
	
	var dir = (get_player().global_position - shoot_point.global_position).normalized()
	
	var spread_deg = 5.0  
	var spread_rad = deg_to_rad(randf_range(-spread_deg, spread_deg))

	var final_angle = dir.angle() + spread_rad
	var final_dir = Vector2.RIGHT.rotated(final_angle)

	bull.direction = final_dir
	bull.rotation = final_angle


func _physics_process(delta: float) -> void:
	super(delta)
	if not get_player():
		return
	
	var dist = calc_distant()
	if dist <= distant_to_attack:
		if not is_in_attack_range:
			is_in_attack_range = true
			fsm.change_to("FarAttack")  
	else:
		if is_in_attack_range:
			is_in_attack_range = false
			to_default_state() 


func calc_distant():
	return position.distance_to(get_player().global_position)
