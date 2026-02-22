extends CharacterBody2D

@export var speed: float = 80
@export var health: int = 3
@export var chase_range: float = 600.0

@onready var player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	if player:
		var distance = global_position.distance_to(player.global_position)

		if distance < chase_range and distance > 120:
			var direction = (player.global_position - global_position).normalized()
			velocity = direction * speed
		else:
			velocity = Vector2.ZERO
		move_and_slide()

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()
