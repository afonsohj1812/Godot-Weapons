class_name Entity extends CharacterBody2D

signal health_changed(health: int)
signal damaged(damage: int)
signal died


const GROUP: StringName = &"Entities"

@export var maxHealth: int = 100
@export var speed: float = 100
@export var weight: float = 1000
@export var hurtbox: Hurtbox

var health: int
var knockback: Vector2


func _ready() -> void:
	health = maxHealth
	hurtbox.hit.connect(takeAttack)

	add_to_group(Entity.GROUP)


func _physics_process(delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, weight * delta)

	velocity = getMovement(delta) + knockback
	move_and_slide()


func getMovement(_delta: float) -> Vector2:
	return Vector2.ZERO


func takeAttack(attack: Attack) -> void:
	takeDamage(attack.getDamage())
	
	knockback += Vector2.RIGHT.rotated(attack.rotation) * attack.knockback


func takeDamage(damage: int) -> void:
	if (health <= 0):
		return

	health = max(health - damage, 0)
	
	health_changed.emit(health)
	damaged.emit(damage)

	_on_hit(damage)
	if (health <= 0):
		_on_death()
		died.emit()


func _on_hit(_damage: int) -> void:
	pass


func _on_death() -> void:
	queue_free()
