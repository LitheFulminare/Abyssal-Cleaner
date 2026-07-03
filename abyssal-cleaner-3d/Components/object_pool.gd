class_name ObjectPool extends Node

var _pool: Array[Projectile] = []
var object: PackedScene

func create_pool(projectile_scene:PackedScene, ammount: int) -> void:
	object = projectile_scene
	for i in ammount:
		var projectile: Projectile = object.instantiate()
		add_child(projectile)
		projectile.expired.connect(release)
		_pool.append(projectile)

func acquire() -> Projectile:
	var projectile: Projectile
	
	if _pool.is_empty():
		projectile = object.instantiate()
		add_child(projectile)
		projectile.expired.connect(release)
		projectile.enable()
		return projectile
	
	projectile = _pool.pop_back()
	projectile.enable()
	
	return projectile
	
func release(projectile: Projectile) -> void:
	_pool.append(projectile)
