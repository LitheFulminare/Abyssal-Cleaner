class_name Cannon extends Weapon

const CANNON_PROJECTILE = preload("uid://0xuu7gjli1to")

@export var weapon_stats: WeaponStats

func initialize() -> void:
	stats = weapon_stats
	
	set_firing_mode()
	
	spawn_point = %ProjectileSpawnPoint
	projectile_pool = %ObjectPool
	cooldown_timer = %CooldownTimer
	cooldown_timer.timeout.connect(on_cooldown_timer_timeout)
	projectile_pool.create_pool(CANNON_PROJECTILE, 20)
	projectile_scene = CANNON_PROJECTILE
	shoot_delay = 1 / stats.fire_rate

func set_firing_mode() -> void:
	match stats.firing_type:
		stats.FIRING_TYPE.AUTOMATIC:
			current_weapon_firing_mode = shoot_automatic
		stats.FIRING_TYPE.BURST:
			current_weapon_firing_mode = shoot_burst
		stats.FIRING_TYPE.LASER:
			current_weapon_firing_mode = shoot_laser
