@tool
class_name WeaponStats extends Resource

enum FIRING_TYPE {AUTOMATIC, BURST, LASER}
enum AMMO_TYPE {OVERHEAT, AMMO}

@export_group("Weapon Info")
@export var name: String = "Canon"
@export var damage: float = 10
@export_custom(PROPERTY_HINT_NONE, "suffix:sec") var projectile_lifespan: float = 1

@export_group("Firing properties")
@export var firing_type: FIRING_TYPE = FIRING_TYPE.AUTOMATIC:
	set(value):
		firing_type = value
		notify_property_list_changed()

# Automatic
@export_custom(PROPERTY_HINT_NONE, "suffix:bullets/sec") var fire_rate: float = 2 

# Burst
@export var shots_per_burst: int = 3
@export_custom(PROPERTY_HINT_NONE, "suffix:sec") var burst_delay: float = 0.75

@export_group("Ammo properties")
@export var ammo_type: AMMO_TYPE = AMMO_TYPE.OVERHEAT:
	set(value):
		ammo_type = value
		notify_property_list_changed()

# Overheat
@export var max_heat: float = 100
@export_custom(PROPERTY_HINT_NONE, "suffix:heat/shot") var heat_buildup: float = 10
@export_custom(PROPERTY_HINT_NONE, "suffix:sec") var cool_delay: float = 1
## Heat lost per second.
@export_custom(PROPERTY_HINT_NONE, "suffix:heat/sec") var heat_loss: float = 20
@export_custom(PROPERTY_HINT_NONE, "suffix:sec") var overheat_cooldown: float = 5

# Ammo
@export var ammo: int = 20

func _validate_property(property: Dictionary) -> void:
	match property.name:
		# Firing Type
		"fire_rate":
			if firing_type != FIRING_TYPE.AUTOMATIC:
				property.usage = PROPERTY_USAGE_NO_EDITOR
		"shots_per_burst", "burst_delay":
			if firing_type != FIRING_TYPE.BURST:
				property.usage = PROPERTY_USAGE_NO_EDITOR
				
		# Ammo Type
		"heat_buildup", "overheat_cooldown", "heat_loss", "overheat_cooldown":
			if ammo_type != AMMO_TYPE.OVERHEAT:
				property.usage = PROPERTY_USAGE_NO_EDITOR
		"ammo":
			if ammo_type != AMMO_TYPE.AMMO:
				property.usage = PROPERTY_USAGE_NO_EDITOR
