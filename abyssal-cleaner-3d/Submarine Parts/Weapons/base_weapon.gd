## Base class of a weapon, can be used by players and enemies.
@abstract class_name Weapon extends Node

var stats: WeaponStats
var projectile_pool: ObjectPool
var spawn_point: Marker3D
var projectile_scene: PackedScene
var cooldown_timer: Timer

var cooldown: float
var can_fire: bool = true
var shoot_delay: float
var current_heat: float = 0.0
var is_cooling_down: bool = false
var weapon_overheated: bool = false

var current_weapon_firing_mode: Callable

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if is_cooling_down:
		cooldown_weapon(delta)
	
	if can_fire == false:
		cooldown += delta
		if cooldown > shoot_delay:
			can_fire = true
			cooldown = 0.0

@abstract
func initialize() -> void

func shoot() -> void:
	if !can_fire || weapon_overheated:
		return
	
	# Without this, the weapon cools down while shooting, could be interesting
	is_cooling_down = false 
	current_weapon_firing_mode.call()

func shoot_automatic() -> void:
	_spawn_projectile()
	if stats.ammo_type == stats.AMMO_TYPE.OVERHEAT:
		increase_heat()
	
	can_fire = false

func shoot_burst() -> void:
	print("Burst shot (method not implemented)")
	
func shoot_laser() -> void:
	print("Laser shot (method not implemented)")

func _spawn_projectile() -> void:
	var projectile: Projectile = projectile_pool.acquire()
	projectile.global_position = spawn_point.global_position
	projectile.direction = -spawn_point.global_transform.basis.z.normalized()
	projectile.global_transform.basis = spawn_point.global_transform.basis

func increase_heat() -> void:
	current_heat += stats.heat_buildup
	if current_heat >= stats.max_heat:
		current_heat = 100.0
		overheat()
	else:
		cooldown_timer.start(stats.cool_delay)
	print("Current Heat: " + str(current_heat))

func overheat() -> void:
	# Trigger particles and sounds here
	weapon_overheated = true
	print("WEAPON OVERHEATED")
	cooldown_timer.start(stats.overheat_cooldown)

func cooldown_weapon(delta: float) -> void:
	print("Cooling down")
	current_heat -= stats.heat_loss * delta
	if current_heat <= 0.0:
		current_heat = 0.0
		is_cooling_down = false
		weapon_overheated = false
	print("Current heat: " + str(current_heat))

func on_cooldown_timer_timeout() -> void:
	is_cooling_down = true
