class_name Projectile extends Area3D

## ObjectPool listens to this and adds the projectile back to the pool.
signal expired(projectile: Projectile)

@onready var collision_shape: CollisionShape3D = %CollisionShape3D

var speed: float = 50
var direction: Vector3 = Vector3(0, 0, 1)
var lifespan: float = 1

## Disables collision and movement. Starts as true because all projectiles use object pooling.
var disabled: bool = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func enable() -> void:
	collision_shape.set_deferred("disabled", false)
	visible = true
	disabled = false

func disable() -> void:
	collision_shape.set_deferred("disabled", true)
	expired.emit(self)
	visible = false
	disabled = true
