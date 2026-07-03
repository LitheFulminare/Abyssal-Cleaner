## Base class of a weapon, can be used by players and enemies. Override its shoot() method.
@abstract class_name Weapon extends Node

var stats: WeaponStats
var projectile_pool: ObjectPool
var spawn_point: Marker3D
var projectile_scene: PackedScene

var cooldown: float
var can_fire: bool = true
var shoot_delay: float

var current_weapon_firing_mode: Callable

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if can_fire == false:
		cooldown += delta
		if cooldown > shoot_delay:
			can_fire = true
			cooldown = 0

@abstract
## Set stats, projectile_pool, spawn_point and projectile_scene.
func initialize() -> void

func shoot() -> void:
	current_weapon_firing_mode.call()

func shoot_automatic() -> void:
	if !can_fire:
		return
	
	var projectile: Projectile = projectile_pool.acquire()
	projectile.global_position = spawn_point.global_position
	projectile.direction = -spawn_point.global_transform.basis.z.normalized()
	projectile.global_transform.basis = spawn_point.global_transform.basis
	
	can_fire = false

func shoot_burst() -> void:
	print("Burst shot (method not implemented)")
	
func shoot_laser() -> void:
	print("Laser shot (method not implemented)")
