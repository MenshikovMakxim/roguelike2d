extends Area2D

@export var speed: float = 600.0
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
var damage = Global.attack * 1.2
var direction: Vector2 = Vector2.ZERO
var fly := true


func _play_anim(_name : String, _fn : Callable = Callable()) -> void:
	anim.stop()
	anim.play(_name)
	if _fn:
		await anim.animation_finished
		_fn.call()


func _ready():
	add_to_group("player_bullets")


func _fly() -> void:
	$AnimatedSprite2D.play("idle")


func _physics_process(delta):
	if not fly:
		return
	_fly()
	position += direction * speed * delta


func _damage(body):
	direction = Vector2.ZERO
	$CollisionShape2D.set_deferred("disabled", true)
	body.take_damage(damage)
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	fly = false
	if body is Enemy:
		_damage(body)
	else:
		_play_anim("destroy", queue_free)
