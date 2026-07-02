class_name Cannon extends Weapon

const CANNON_PROJECTILE = preload("uid://0xuu7gjli1to")

func initialize() -> void:
	spawn_point = %ProjectileSpawnPoint
	projectile_scene = CANNON_PROJECTILE
	create_object_pool(20)

func shoot() -> void:
	if projectile_index > last_projectile_index:
		projectile_index = 0
	
	projectile_pool[projectile_index].enable()
	projectile_pool[projectile_index].global_position = spawn_point.global_position
	
	projectile_index += 1
