extends CharacterBody2D

# Boblin's stats
@export var player_stats: PlayerStats = PlayerStats.new()

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
		
	# Player move speed determined by the Move Speed stat.
	velocity = input_dir * player_stats.get_move_speed()
	move_and_slide()
