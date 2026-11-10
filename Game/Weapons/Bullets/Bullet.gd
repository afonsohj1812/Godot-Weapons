class_name Bullet extends Hitbox


var speed: float
var range: float
var hitCount: int


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	var distance: float = speed * delta
	global_position += Vector2.RIGHT.rotated(rotation) * distance

	range -= distance
	if (range <= 0):
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if (area is Hurtbox):
		hitCount -= 1

		if (hitCount <= 0):
			queue_free()
