extends Resource
class_name Upgrade

enum StatType { HEALTH, SPEED, DAMAGE }

@export var upgrade_name: String
@export var stat_to_modify: StatType
@export var value_add: float = 0.0
@export var value_mult: float = 0.0 # Наприклад, +10% це 0.1

func apply(stats: StatsDef):
	match stat_to_modify:
		StatType.HEALTH:
			stats.max_health += int(value_add)
		StatType.SPEED:
			stats.damage = int(stats.speed * (1.0 + value_mult))
		StatType.DAMAGE:
			stats.damage = int(stats.damage * (1.0 + value_mult))
	print("Upgrade applied: ", upgrade_name)
