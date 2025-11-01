extends Area2D

@export var speed: float = 600.0
var direction: Vector2 = Vector2.ZERO
var dead := false

func _physics_process(delta):
	if dead:
		return
	$AnimatedSprite2D.play("idle")
	position += direction * speed * delta

func _on_area_entered(area):
	# отложим вызов функции _die, чтобы не лезть в физику во время расчётов
	call_deferred("_die")

func _die():
	if dead:
		return
	dead = true

	# отключаем коллизию безопасно
	$CollisionShape2D.set_deferred("disabled", true)

	# проигрываем анимацию взрыва
	$AnimatedSprite2D.play("destroy")

	# ждём конца анимации
	await $AnimatedSprite2D.animation_finished
	queue_free()
