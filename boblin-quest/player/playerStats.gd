extends Resource
class_name PlayerStats
signal health_changed(current: int, max_hp: int)
#  Base Stats
# -----------------------------------
@export var base_health: int = 100
@export var move_speed: float = 250.0
@export var base_damage: int = 3
@export var attack_speed: float = 1.0 # TODO: Cap Attack speed at something reasonable (like 2.0)

# Player Health at RUNTIME
@export var player_health: int = 100

# Additional Stats
# -----------------------------------
# These stats are added on the base stats DURING gameplay
var additional_health: int = 0
var additional_move_speed: float = 0.0
var additional_damage: int = 0
@export var additional_attack_speed: float = 0.0 # TODO: Cap Attack speed at something reasonable (like 2.0)


# Stat functions
# -----------------------------------
# Change player stats at RUNTIME
func get_max_health() -> int:
	return base_health + additional_health

func get_damage() -> int:
	return base_damage + additional_damage

func get_move_speed() -> float:
	return move_speed + additional_move_speed

func get_attack_speed() -> float:
	return attack_speed + additional_attack_speed

# Gameplay
# -----------------------------------
# Sets the base stats for the player on the first run.
func start_run():
	reset_run_bonuses()
	
	# Should reset to base since bonuses were cleared.
	# DOUBLE CHECK THIS
	#player_health = get_max_health()
	health_changed.emit(player_health, get_max_health())

# Resets the collected item bonuses collected IN RUN
func reset_run_bonuses():
	additional_health = 0
	additional_damage = 0
	additional_move_speed = 0
	additional_attack_speed = 0

# Damage
# -----------------------------------
# Take the player health, subtract damage amount. Applies the damage
# if it falls between the current, min, and max player health.
func apply_damage(damage_amount: int) -> void:
	player_health = clamp(player_health - damage_amount, 0, get_max_health())
	health_changed.emit(player_health, get_max_health())

# Determine whether the player is dead
func is_dead() -> bool:
	return player_health <=0

# Heals the player on item pickup
func heal(amount: int = 0) -> void:
	if amount > 0:
		player_health = clamp(player_health + amount, 0, get_max_health())
	else:
		player_health = clamp(player_health, 0, get_max_health())
	health_changed.emit(player_health, get_max_health())

# Applies stat changes from item pickups (called by ItemPickupScript)
func apply_stat_modifiers(modifiers: Dictionary) -> void:
	if modifiers.has("max_health"):
		additional_health += int(modifiers["max_health"])
	if modifiers.has("heal"):
		heal(int(modifiers["heal"]))
	if modifiers.has("damage"):
		additional_damage += int(roundf(modifiers["damage"]))
	if modifiers.has("attack_speed"):
		additional_attack_speed += float(modifiers["attack_speed"])
	if modifiers.has("move_speed"):
		additional_move_speed += float(modifiers["move_speed"])
