extends ProgressBar

func _ready() -> void:
	print("=== HP BAR READY ===", get_path())

	var player = get_tree().get_first_node_in_group("Player")
	print("Found player:", player)

	if not player:
		return

	print("Player stats object:", player.player_stats)

	if player.player_stats:
		player.player_stats.health_changed.connect(update_hp)
		print("Connected to health_changed")
		update_hp(player.player_stats.player_health, player.player_stats.get_max_health())
	else:
		push_warning("Player has no player_stats assigned!")

func update_hp(current: int, max_hp: int) -> void:
	print("HP update:", current, "/", max_hp)
	max_value = max_hp
	value = current
