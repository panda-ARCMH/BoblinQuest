extends Resource
class_name PlayerStats

## Base Stats
## -----------------------------------

var base_health: float = 100.0
var move_speed: float = 200.0
var base_damage: float = 3.0
var attack_speed: float = 1.0 # TODO: Cap Attack speed at something reasonable (like 2.0)

## Player Health at RUNTIME
var player_health: float = 100.0

## Additional Stats
## These stats are added on the base stats DURING gameplay
## -----------------------------------

var additional_health: float = 0.0
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

## Determine whether the player is dead
func is_dead() -> bool:
	return player_health <= 0.0

# TODO: Add item pick up functions
## Stat Modification With Items
## -----------------------------------

## Increases player max HP
func on_add_max_health() -> void:
	additional_health += 1.0
	player_health = clamp(player_health, 0, get_max_health())

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
