extends Node

var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func damage_taken(base_damage: float, attack: float, defense: float, invincibility: float = false) -> int:
	if invincibility: return 0
	var total_dmg = base_damage * attack / (base_damage + defense)
	var offset = rng.randf_range((-1) * total_dmg * 0.1, total_dmg * 0.1)
	total_dmg = (base_damage *  attack / (base_damage + defense) + offset)
	var critical_hit = int(rng.randf_range(0, 25))
	if critical_hit == 1:
		total_dmg *= 1.5
		GameManager.criticalHit = true
	else:
		GameManager.criticalHit = false
	return round(total_dmg)
