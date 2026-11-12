@tool
class_name Weapon extends Node2D


@export var stats: WeaponStats:
	set(value):
		stats = value
		if (is_node_ready()):
			load_weapon()

@export var sprite: Sprite2D
@export var bullet: PackedScene
@export var muzzleFlash: GPUParticles2D

var fireCooldown: float = 0


func _ready() -> void:
	load_weapon()


func load_weapon() -> void:
	sprite.texture = stats.texture
	position = stats.pivotPos
	muzzleFlash.position = stats.muzzlePos


func _process(delta: float) -> void:
	fireCooldown -= delta


func shoot() -> void:
	if (fireCooldown > 0):
		return

	fireCooldown = 1.0 / stats.fireRate
	for i in range(stats.multishot):
		spawnBullet()

	muzzleFlash.restart()


func spawnBullet() -> void:
	var bulletScene: Bullet = bullet.instantiate()
	bulletScene.global_position = to_global(stats.muzzlePos)

	bulletScene.attack = stats.attack.duplicate()
	bulletScene.attack.knockback = stats.bullet.weight * stats.bulletSpeed
	bulletScene.speed = stats.bulletSpeed
	bulletScene.distance = stats.bulletRange
	bulletScene.hits = stats.followThrough

	var spread: float = stats.spread / 2 * PI / 180
	bulletScene.rotation = global_rotation + randf_range(-spread, spread)
	bulletScene.attack.rotation = bulletScene.rotation
	
	bulletScene.load_bullet(stats.bullet.texture, stats.bullet.size)
	get_tree().current_scene.add_child(bulletScene)
