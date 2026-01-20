extends Character
class_name Hero

var fireballs = {
	"standart" : load("res://main/bullets/hero_bullet.tscn"),
	"mass" : load("res://main/bullets/mass_hero_bullet.tscn")
}

@onready var shoot_point = $Face/Marker2D
@onready var flash = $Face/Marker2D/PointLight2D
@onready var collector = $Collector
@onready var camera = $Camera2D
@onready var hud = $Hud
var obsession = false


func _ready():
	super()
	add_to_group("hero")
	Global.connect("attack_player", Callable(self, "take_damage"))
	default_state = "Move"
	fsm.change_to("Move")
	super.setup(Stats.hp, Stats.speed, Stats.attack, attack_frames, die_frame)


func take_damage(amount):
	super(amount)
	hud.update(health)


func do_attack():
	var _fireball = fireballs["standart"].instantiate()
	get_tree().current_scene.add_child(_fireball)
	_fireball.set_damage(Stats.attack)
	_fireball.global_position = shoot_point.global_position

	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - shoot_point.global_position).normalized()

	var spread_deg = 1.0  
	var spread_rad = deg_to_rad(randf_range(-spread_deg, spread_deg))

	var final_angle = dir.angle() + spread_rad
	var final_dir = Vector2.RIGHT.rotated(final_angle)

	_fireball.direction = final_dir
	_fireball.rotation = final_angle


func set_limits_from_layer(layer: TileMapLayer):
	var rect := layer.get_used_rect()
	if rect.size == Vector2i.ZERO:
		return

	var tile_size := layer.tile_set.tile_size
	var offset := layer.global_position

	camera.limit_left = rect.position.x * tile_size.x + offset.x
	camera.limit_top = rect.position.y * tile_size.y + offset.y
	camera.limit_right = rect.end.x * tile_size.x + offset.x
	camera.limit_bottom = rect.end.y * tile_size.y + offset.y
