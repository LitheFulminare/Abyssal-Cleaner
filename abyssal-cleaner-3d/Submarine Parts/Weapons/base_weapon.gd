## Base class of a weapon, can be used by players and enemies. Override its shoot() method.
@abstract class_name Weapon extends Node

var stats: WeaponStats

var projectile_pool: ObjectPool

var spawn_point: Marker3D

var projectile_scene: PackedScene

## Whether the weapons has overheat or ammo mechanic.
var can_overheat: bool = true

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

@abstract
## Override this funcion instead of ready()
func initialize() -> void

@abstract
func shoot() -> void
