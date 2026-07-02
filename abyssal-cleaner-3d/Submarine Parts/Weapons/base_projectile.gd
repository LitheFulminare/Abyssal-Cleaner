class_name Projectile extends Area3D

var speed: float = 50
var direction: Vector3 = Vector3(0, 0, 1)
var lifespan: float = 1

## Disables collision and movement. Starts as true because all projectiles use object pooling.
var disabled: bool = true

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func enable() -> void:
	visible = true
	disabled = false

func disable() -> void:
	visible = false
	disabled = true
