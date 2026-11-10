class_name Game extends Node2D


@export var attack: Attack
@export var dummy: PackedScene
@export var pivot: Node2D
@export var weapon: Weapon


func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Spawn")):
		var mousePos: Vector2 = get_global_mouse_position()

		var dummyScene: Node2D = dummy.instantiate()
		dummyScene.position = mousePos

		add_child(dummyScene)


func _process(delta: float) -> void:
	pivot.look_at(get_global_mouse_position())

	if (Input.is_action_pressed("Shoot")):
		weapon.shoot(delta)
