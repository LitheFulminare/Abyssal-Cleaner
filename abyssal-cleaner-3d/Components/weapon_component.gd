class_name WeaponComponent extends Node

@export var weapon: Weapon

func shoot() -> void:
	if weapon == null:
		return
		
	weapon.shoot()
