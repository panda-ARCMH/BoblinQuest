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
