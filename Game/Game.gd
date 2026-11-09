class_name Game extends Node2D


@export var attack: Attack
@export var dummy: PackedScene


func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Spawn")):
		var mousePos: Vector2 = get_global_mouse_position()

		var dummyScene: Node2D = dummy.instantiate()
		dummyScene.position = mousePos

		add_child(dummyScene)
