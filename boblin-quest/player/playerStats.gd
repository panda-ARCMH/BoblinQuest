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
var additional_damage: float = 0.0
var additional_attack_speed: float = 0.0 # TODO: Cap Attack speed at something reasonable (like 2.0)


## Getter Stat Functions
## -----------------------------------

func get_max_health() -> float:
	return base_health + additional_health

func get_damage() -> float:
	return base_damage + additional_damage

func get_move_speed() -> float:
	return move_speed + additional_move_speed

func get_attack_speed() -> float:
	return attack_speed + additional_attack_speed

## Gameplay
## -----------------------------------

## Sets the base stats for the player on the first run.
func start_run():
	reset_run_bonuses()
	
	# Should reset to base since bonuses were cleared.
	# DOUBLE CHECK THIS
	player_health = get_max_health()
	health_changed.emit(player_health, get_max_health())

## Resets the collected item bonuses collected IN RUN
func reset_run_bonuses():
	additional_health = 0.0
	additional_damage = 0.0
	additional_move_speed = 0.0
	additional_attack_speed = 0.0


## Damage / Death 
## -----------------------------------

## Take the player health, subtract damage amount. Applies the damage
## if it falls between the current, min, and max player health.
func apply_damage(damage_amount: float) -> void:
	player_health = clamp(player_health - damage_amount, 0, get_max_health())
	health_changed.emit(player_health, get_max_health())

## Determine whether the player is dead
func is_dead() -> bool:
	return player_health <= 0.0

## Stat Modification With Items
## -----------------------------------

## Increases player max HP
func on_add_max_health(amount: float = 1.0) -> void:
	additional_health += amount
	player_health = clamp(player_health, 0.0, get_max_health())

## Apply healing to the player current HP
func on_add_healing(amount: float) -> void:
	player_health = clamp(player_health + amount, 0, get_max_health())

## Increase the player max damage per attack
func on_add_damage(amount: float) -> void:
	additional_damage += amount

## Apply movement speed increase to the player
func on_add_max_speed(amount: float) -> void:
	additional_move_speed += amount

## Apply attack speed increase to the player
func on_add_attack_speed(amount: float) -> void:
	additional_attack_speed += amount

## Applies the stat modifier to the player depending on the type of item
## that is picked up. refer to ItemPickup.gd to see the dictionary.
func apply_stat_modifiers(modifiers: Dictionary) -> void:
	for stat_key in modifiers.keys():
		var amount: float = float(modifiers[stat_key])
		match String(stat_key):
				"max_health":
					on_add_max_health(amount)
				"heal":
					on_add_healing(amount)
				"damage":
					on_add_damage(amount)
				"move_speed":
					on_add_max_speed(amount)
				"attack_speed":
					on_add_attack_speed(amount)
