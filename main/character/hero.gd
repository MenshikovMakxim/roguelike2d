extends CharacterBody2D

@onready var speed = Global.speed
@export var attack = 1
@onready var shoot_point = $Face/Marker2D
@onready var anim = $Face/AnimatedSprite2D
@onready var effects = $Face/Effects
@onready var flash = $Face/Marker2D/PointLight2D
@onready var face = $Face
@onready var fsm = $StateMachine
@export var projectile_scene: PackedScene

var attack_frame_to_shoot = 8

func _ready():
	Eventbus.connect("attack_player", Callable(self, "take_damage"))
	add_to_group("player")
	fsm.init(self)
	fsm.change_to("Move")
#func _on_animated_sprite_2d_animation_finished() -> void:
	#Eventbus.animation_finished.emit()
	
func play_anim(_name : String, fn: Callable = Callable()):
	anim.play(_name)
	if effects.sprite_frames.has_animation(_name):
		effects.show()
		effects.play(_name)
	await anim.animation_finished
	effects.hide()
	if fn:
		fn.call()


func _physics_process(delta):
	fsm.physics_update(delta)
	if Global.hp <= 0:
		$HitBox/CollisionShape2D.set_deferred("disabled", true)
		fsm.change_to("Die")


# --- АТАКА, УНІВЕРСАЛЬНА ЧЕРЕЗ attack() ---
#func attack():
	#anim.play("attack")

func shoot():
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = shoot_point.global_position

	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - shoot_point.global_position).normalized()

	projectile.direction = dir
	projectile.rotation = dir.angle()
	shoot_flash()


func shoot_flash():
	flash.visible = true
	await get_tree().create_timer(1).timeout
	flash.visible = false

func take_damage(amount):
	Global.hp -= amount
	print("My HP:", Global.hp)
	fsm.change_to("Damage")
	#anim.play("damage")

#func die():
	#await anim.animation_finished
	#queue_free()

func _on_animated_sprite_2d_frame_changed() -> void: 
	if anim.animation == "attack" and anim.frame == attack_frame_to_shoot: 
		shoot() 
		#Eventbus.emit_signal("damage_taken", 25)

#func _on_hit_box_area_entered(_area: Area2D) -> void:
	##fsm.change_to("Damage")
	#print("damage")


func _on_animated_sprite_2d_animation_finished() -> void:
	if Global.hp > 0:
		fsm.to_default()
