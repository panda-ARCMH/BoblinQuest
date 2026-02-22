extends CharacterBody2D

# Node Calls
@export var player_stats: PlayerStats = PlayerStats.new()
@onready var sprite = self.get_node("AnimatedSprite2D")

func _ready() -> void:
	player_stats.start_run();

# Player movement
func _physics_process(_delta: float) -> void:
	var input_dir:= Input.get_vector(
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
	
	# Player move speed determined by the Move Speed stat.
	velocity = input_dir * player_stats.get_move_speed()
	move_and_slide()
