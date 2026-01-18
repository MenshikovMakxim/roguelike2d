extends Resource
class_name Ability

@export var name: String
@export var icon: Texture2D
@export var cooldown: float = 1.0
@export var damage_multiplier: float = 1.0

# Віртуальна функція, яку ми перевизначимо для конкретних атак
func execute(user: Node2D, target_position: Vector2):
	print("Base ability used")
