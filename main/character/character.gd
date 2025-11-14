extends CharacterBody2D
class_name Character

@export var health: int 
@export var speed : float
@export var attack : float
@onready var attack_frame : int
@onready var anim = $Face/Animation
@onready var effects = $Face/Effects
@onready var face = $Face
@onready var fsm = $StateMachine

func _init() -> void:
	pass


func _ready() -> void:
	fsm.init(self)
	effects.hide()


func play_anim(_name : String, fn: Callable = Callable()):
	anim.play(_name)
	if effects.sprite_frames.has_animation(_name):
		effects.show()
		effects.play(_name)
	await anim.animation_finished
	effects.hide()
	if fn:
		fn.call()


func _physics_process(delta: float) -> void:
	fsm.physics_update(delta)
	if health <= 0:
		$HitBox/CollisionShape2D.set_deferred("disabled", true)
		fsm.change_to("Die")


func take_damage(amount):
	health -= amount
	fsm.change_to("Damage")


func do_attack():
	pass


func _on_animated_sprite_2d_frame_changed() -> void: 
	if anim.animation == "attack" and anim.frame == attack_frame: 
		do_attack() 


func _on_animated_sprite_2d_animation_finished() -> void:
	if health > 0:
		fsm.to_default()
