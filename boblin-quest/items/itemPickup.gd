extends Area2D
class_name ItemPickupScript

@export var item_id: String

## Dictionary for items that modify stats
const STAT_MODIFIERS := {
	"grum_grum_juice": {"max_health": 1},
	"healing_potion": {"heal": 25.0},
	"brown_goop": {"damage": 0.2},
	"banana": {"attack_speed": 0.2},
	"energy_drink": {"move_speed": 25.0},
}

func _ready() -> void:
	body_entered.connect(_on_body_entered)

# Applies the stat modification when the player walks into the pickup area
func _on_body_entered(body: Node) -> void:
	
	## Only allow things that can provide PlayerStats
	if not body.has_method("get_player_stats"):
		return

	## Ensure the item actually exists
	if not STAT_MODIFIERS.has(item_id):
		push_warning("Unknown item_id: %s" % item_id)
		return

	var stats: PlayerStats = body.get_player_stats()
	
	## Apply modifiers for this item
	stats.apply_stat_modifiers(STAT_MODIFIERS[item_id])

	## Remove pickup when item has been used
	queue_free()
