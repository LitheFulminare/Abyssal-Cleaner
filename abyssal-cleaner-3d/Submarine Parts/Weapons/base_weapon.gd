## Base class of a weapon, can be used by players and enemies. Override its shoot() method.
@abstract class_name Weapon extends Node

var projectile_pool: ObjectPool

var damage: float = 10
var hit_cooldown: float = 0.1
var max_heat: float = 100
## It's not defined by default how many times per seconds heat is applied.
var heat_per_sec: float = 15 
var ammo: int = 0
var projectile_lifespan: float = 1

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
