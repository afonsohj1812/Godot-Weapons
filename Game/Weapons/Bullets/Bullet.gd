class_name Bullet extends Hitbox


@export var sprite: Sprite2D
@export var collision: CollisionShape2D

var speed: float
var distance: float
var hits: int


func _physics_process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(rotation) * speed * delta

	distance -= speed * delta
	if (distance <= 0):
		queue_free()


func tryHit() -> bool:
	if (hits <= 0):
		return false

	hits -= 1
	if (hits <= 0):
		queue_free()
	return true


func load_bullet(texture: Texture2D, size: Vector2) -> void:
	sprite.texture = texture
	var shape: RectangleShape2D = RectangleShape2D.new()
	shape.size = size
	collision.shape = shape
