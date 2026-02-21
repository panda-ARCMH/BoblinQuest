extends Area2D
class_name ItemPickup

@export var item_id: String

const STAT_MODIFIERS := {
	"grum_grum_juice": {"max_health": 1},
	"healing_potion": {"heal": 25.0},
	"brown_goop": {"damage": 0.2},
	"banana": {"attack_speed": 0.2},
	"energy_drink": {"move_speed": 25.0},
}
