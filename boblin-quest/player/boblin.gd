extends CharacterBody2D

# Node Calls
@export var player_stats: PlayerStats = PlayerStats.new()
@onready var sprite = self.get_node("AnimatedSprite2D")
@onready var attack_hitbox: Area2D = $AttackHitbox

const ATTACK_OFFSET := 18.0
var attacking := false
var attack_cooldown := 0.0

func get_player_stats() -> PlayerStats:
	return player_stats

func _ready() -> void:
	player_stats.start_run()
	attack_hitbox.collision_mask = 0

# Player movement and attack
func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)

	# Sprite Animation
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		sprite.flip_h = true

	if input_dir:
		sprite.play("move")
	else:
		sprite.stop()

	# Attack (left click)
	attack_cooldown = maxf(0.0, attack_cooldown - delta)
	if attacking:
		for body in attack_hitbox.get_overlapping_bodies():
			if body != self and body.has_method("take_damage"):
				body.take_damage(player_stats.get_damage())
		attack_hitbox.collision_mask = 0
		attacking = false
	elif Input.is_action_just_pressed("attack") and attack_cooldown <= 0.0:
		print("Boblin attack - atk speed: %s, damage: %s" % [player_stats.get_attack_speed(), player_stats.get_damage()])
		attack_hitbox.position = Vector2(ATTACK_OFFSET if not sprite.flip_h else -ATTACK_OFFSET, 0)
		attack_hitbox.collision_mask = 1
		attacking = true
		attack_cooldown = 1.0 / player_stats.get_attack_speed()

	# Player move speed determined by the Move Speed stat.
	velocity = input_dir * player_stats.get_move_speed()
	move_and_slide()