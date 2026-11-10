@tool
class_name Weapon extends Node2D


@export var stats: WeaponStats:
	set(value):
		stats = value
		if (Engine.is_editor_hint()):
			load_weapon()

@export var sprite: Sprite2D
@export var bullet: PackedScene

var fireCooldown: float = 0


func _ready() -> void:
	load_weapon()


func load_weapon() -> void:
	sprite.texture = stats.texture
	position = stats.pivotPos


func shoot(delta: float) -> void:
	if (!canShoot(delta)):
		return

	for i in range(stats.multishot):
		var bulletScene: Bullet = bullet.instantiate()
		bulletScene.global_position = to_global(stats.muzzlePos)

		bulletScene.attack = stats.attack
		bulletScene.speed = stats.bulletSpeed
		bulletScene.range = stats.bulletRange
		bulletScene.hitCount = stats.followThrough

		var spread: float = stats.spread / 2 * PI / 180
		bulletScene.rotation = global_rotation + randf_range(-spread, spread)
		
		get_tree().current_scene.add_child(bulletScene)


func canShoot(delta: float) -> bool:
	fireCooldown -= delta
	if (fireCooldown > 0):
		return false

	fireCooldown = 1.0 / stats.fireRate
	return true
