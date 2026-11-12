class_name Attack extends Resource


@export var damage: int = 1
@export var critDamage: float = 2
@export var critChance: float = 0.2
@export var knockback: float = 0

var rotation: float


func getDamage() -> int:
	var damageValue: float = damage * (critDamage if randf() < critChance else 1.0)

	return roundi(damageValue)
