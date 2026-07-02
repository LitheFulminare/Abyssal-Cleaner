class_name Cannon extends Weapon

const CANNON_PROJECTILE = preload("uid://0xuu7gjli1to")

func initialize() -> void:
	spawn_point = %ProjectileSpawnPoint
	projectile_pool = %ObjectPool
	projectile_pool.create_pool(CANNON_PROJECTILE, 20)
	projectile_scene = CANNON_PROJECTILE

func shoot() -> void:
	projectile_pool.acquire().global_position = spawn_point.global_position
