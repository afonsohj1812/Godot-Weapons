class_name Bullet extends Hitbox


var speed: float


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(rotation) * speed * delta


func _on_area_entered(area: Area2D) -> void:
	if (area is Hurtbox):
		queue_free()
