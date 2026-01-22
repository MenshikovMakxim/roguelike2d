extends Resource
class_name Upgrade

enum StatType { HEALTH, SPEED, DAMAGE }

@export var upgrade_name: String
@export var stat_to_modify: StatType
@export var value_mult: float = 0.0 # Наприклад, +10% це 0.1

var changed_stat : Array

func calc_modify(name : String, value: float) -> int:
	var new_value = value * (1.0 + value_mult)
	changed_stat = [name, value, new_value]
	return new_value
	
func apply(stats: StatsDef) -> Array:
	match stat_to_modify:
		StatType.HEALTH:
			stats.max_health = calc_modify("Health", stats.max_health)
		StatType.SPEED:
			stats.speed = calc_modify("Speed", stats.speed)
		StatType.DAMAGE:
			stats.damage = calc_modify("Damage", stats.damage)
	print("Upgrade applied: ", upgrade_name)
	return changed_stat
