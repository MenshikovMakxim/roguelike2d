extends CharacterBody2D
class_name Character

@export var health: int 
@export var speed : float 
@export var attack : float 
@export var attack_frame : int 
@export var die_frame : int
@onready var anim : AnimatedSprite2D = $Face/Animation
@onready var effects : AnimatedSprite2D = $Face/Effects
@onready var face : Node2D = $Face
@onready var shadow : Sprite2D = $Face/Shadow
@onready var fsm : FSM = $StateMachine
@onready var default_state : String
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var hp_bar : ProgressBar
@export var sounds : Dictionary[String, AudioStream] = {"damage":preload("res://assets/sounds/enemy/damage.ogg")}
@export var sounds_volumes : int = 0
#@export var is_dead = false


func _ready() -> void:
	Global.connect("change_volume", Callable(self, "change_volume"))
	fsm.init(self)
	effects.hide()


func _process(delta: float) -> void:
	fsm.physics_update(delta)

#func _physics_process(delta: float) -> void:
	#fsm.physics_update(delta)


func setup(_health:int, _speed:float, _attack:float, _attack_frame:int, _die_frame:int) -> void:
	self.health = _health
	self.speed = _speed
	self.attack = _attack
	self.attack_frame = _attack_frame
	self.die_frame = _die_frame


func play_sound(_name: String, _volume = sounds_volumes):
	if not sounds.has(_name):
		return
		
	#if audio.playing and audio.stream == sounds[_name]:
		#return

	audio.stream = sounds[_name]
	audio.volume_db = Global.calc_volume_effects()
	audio.play()


func play_anim(_name : String, fn: Callable = Callable()):
	if not anim.sprite_frames.has_animation(_name):
		return

	if anim.animation == _name and anim.is_playing():
		return

	anim.play(_name)

	if fn.is_valid():
		await anim.animation_finished
		fn.call()


func play_effects(_name : String):
	if not effects.sprite_frames.has_animation(_name):
		return

	if effects.animation == _name and effects.is_playing():
		return

	effects.show()
	effects.play(_name)
	
	await effects.animation_finished
	effects.hide()


func to_act(_name : String, fn: Callable = Callable()):
	play_anim(_name, fn)
	play_effects(_name)
	play_sound(_name)


func change_volume():
	audio.volume_db = Global.calc_volume_effects()


func take_damage(amount):
	health -= amount
	fsm.change_to("Damage")


func is_alive():
	return health > 0;


func to_default_state():
	fsm.change_to(default_state)


func do_attack():
	pass


func disable():
	$CollisionShape2D.set_deferred("disabled", true)


func _on_animation_animation_finished() -> void:
	if is_alive():
		to_default_state()
