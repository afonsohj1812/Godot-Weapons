class_name Game extends Node2D


@export var attack: Attack
@export var dummy: PackedScene
@export var pivot: Node2D
@export var weapon: Weapon
@export var weapons: Array[WeaponStats]

var weaponIndex: int = 0


func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Spawn")):
		var mousePos: Vector2 = get_global_mouse_position()

		var dummyScene: Node2D = dummy.instantiate()
		dummyScene.position = mousePos
		add_child(dummyScene)
	
	if (event.is_action_pressed("Up")):
		weaponIndex += 1
		load_weapon()
	if (event.is_action_pressed("Down")):
		weaponIndex -= 1
		load_weapon()


func load_weapon() -> void:
	weaponIndex %= weapons.size()
	weapon.stats = weapons[weaponIndex]


func _process(delta: float) -> void:
	var mousePos: Vector2 = get_global_mouse_position()
	pivot.scale.y = -1 if mousePos.x < pivot.global_position.x else 1
	pivot.look_at(mousePos)

	if (Input.is_action_pressed("Shoot")):
		weapon.shoot(delta)
