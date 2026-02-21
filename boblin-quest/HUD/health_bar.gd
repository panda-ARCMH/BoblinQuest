extends ProgressBar

func _ready():
	var player = get_tree().get_first_node_in_group("player")
	player.health_changed.connect(update_hp)

func update_hp(current: int, max_hp: int):
	max_value = max_hp
	value = current
