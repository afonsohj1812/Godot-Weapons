class_name Bullet extends Hitbox


var speed: float
var distance: float
var hits: int


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(rotation) * speed * delta

	distance -= speed * delta
	if (distance <= 0):
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if (area is Hurtbox):
		hits -= 1

		if (hits <= 0):
			queue_free()
