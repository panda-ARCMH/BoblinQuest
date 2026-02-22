<<<<<<< feat/stats-items
#extends Node2D
#
#@export var basic_enemy_scene: PackedScene
#@export var tank_enemy_scene: PackedScene
#@export var ranged_enemy_scene: PackedScene
#
#@onready var enemy_spawner: Node2D = $EnemySpawner
#
#func _ready():
	## Spawn enemies when the dungeon loads
	#spawn_enemy(basic_enemy_scene, Vector2(200, 200))
	#spawn_enemy(basic_enemy_scene, Vector2(250, 250))
	#spawn_enemy(tank_enemy_scene, Vector2(400, 200))
	#spawn_enemy(ranged_enemy_scene, Vector2(300, 400))
#
#func spawn_enemy(scene: PackedScene, position: Vector2):
	#if scene == null:
		#push_error("Enemy scene not assigned in Inspector!")
		#return
#
	#var enemy = scene.instantiate()
	#enemy.global_position = position
	#enemy_spawner.add_child(enemy)
=======
extends Node2D

# Enemy scenes to spawn
@export var basic_enemy_scene: PackedScene
@export var tank_enemy_scene: PackedScene
@export var ranged_enemy_scene: PackedScene

# Number of enemies to spawn
@export var basic_count: int = 3
@export var tank_count: int = 2
@export var ranged_count: int = 2

# Spawn area bounds (adjust for your dungeon/room size)
@export var min_x: float = 50
@export var max_x: float = 750
@export var min_y: float = 50
@export var max_y: float = 550

# Optional: reference to TileMap to prevent spawning inside walls
@export var tilemap: TileMap

func _ready():
	randomize()  # ensure random positions each run

	spawn_multiple_enemies(basic_enemy_scene, basic_count)
	spawn_multiple_enemies(tank_enemy_scene, tank_count)
	spawn_multiple_enemies(ranged_enemy_scene, ranged_count)


# Spawn multiple enemies of a single type
func spawn_multiple_enemies(scene: PackedScene, count: int) -> void:
	for i in count:
		spawn_enemy_random(scene)


# Spawn a single enemy at a random valid position
func spawn_enemy_random(scene: PackedScene) -> void:
	if scene == null:
		push_error("Enemy scene not assigned!")
		return

	var position = get_random_position()
	if position == null:
		push_error("Failed to find a valid spawn position, using default")
		position = Vector2(min_x, min_y)

	var enemy = scene.instantiate()
	enemy.global_position = position
	add_child(enemy)


# Returns a random valid position within bounds (avoids walls if TileMap assigned)
func get_random_position() -> Vector2:
	for i in 20:  # try 20 times to find a free spot
		var x = randi_range(min_x, max_x)
		var y = randi_range(min_y, max_y)
		var pos = Vector2(x, y)

		if tilemap:
			var cell = tilemap.world_to_map(pos)
			if tilemap.get_cell(cell.x, cell.y) == -1:
				return pos  # empty cell
		else:
			return pos  # no TileMap, just return

	# fallback if no free spot found
	return Vector2(min_x, min_y)
>>>>>>> DEV
