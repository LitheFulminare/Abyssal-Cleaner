## Base class of a weapon, can be used by players and enemies. Override its shoot() method.
@abstract class_name Weapon extends Node

var projectile_container: Node

var damage: float = 10
var hit_cooldown: float = 0.1
var max_heat: float = 100
## It's not defined by default how many times per seconds heat is applied.
var heat_per_sec: float = 15 
var ammo: int = 0
var projectile_lifespan: float = 1

var spawn_point: Marker3D

var projectile_scene: PackedScene

var projectile_index: int
var last_projectile_index: int
var projectile_pool: Array[Projectile]

## Whether the weapons has overheat or ammo mechanic.
var can_overheat: bool = true

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func create_object_pool(ammount: int) -> void:
	var start_time: int = Time.get_ticks_usec()
	
	if projectile_container == null:
		printerr("No projectile container found.")
		return
	
	last_projectile_index = ammount - 1
	for i in ammount:
		var projectile: Projectile = projectile_scene.instantiate()
		projectile_container.add_child(projectile)
		projectile.position = spawn_point.global_position
		projectile_pool.append(projectile)
		
	var end_time: int = Time.get_ticks_usec()
	var total_time: int = end_time - start_time
	print(str(total_time) + " microseconds, " + str(total_time / 1000.0) + " milliseconds.")

@abstract
## Override this funcion instead of ready()
func initialize() -> void

@abstract
func shoot() -> void
