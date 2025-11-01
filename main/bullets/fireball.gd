extends Area2D


@export var speed: float = 600.0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		position += direction * speed * delta


func _on_area_entered(area: Area2D) -> void:
	queue_free()
